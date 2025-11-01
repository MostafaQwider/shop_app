import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/entities/product_variants_entity.dart';
import '../../../domain/entities/products_entity.dart';
import '../../../domain/use_cases/cart/add_to_cart_usecase.dart';
import '../../../domain/use_cases/cart/clear_cart_usecase.dart';
import '../../../domain/use_cases/cart/get_cart_usecase.dart';
import '../../../domain/use_cases/cart/mines_quantity_usecase.dart';
import '../../../domain/use_cases/cart/remove_cart_item_usecase.dart';
import '../../../domain/use_cases/product/product_local_usecase.dart';

class CartController extends GetxController {
  final GetCartUseCase getCartItemsUseCase;
  final AddToCartUseCase addCartItemUseCase;
  final RemoveCartItemUseCase removeCartItemUseCase;
  final ClearCartUseCase clearCartUseCase;
  final ProductLocalUseCase productLocalUseCase;
  final MinesQuantityCartUseCase minesQuantityCartUseCase;

  CartController(
    this.getCartItemsUseCase,
    this.addCartItemUseCase,
    this.removeCartItemUseCase,
    this.clearCartUseCase,
    this.productLocalUseCase,
    this.minesQuantityCartUseCase,
  );

  /// 🔁 الحالة العامة (تحميل، نجاح، خطأ)
  StatusRequest statusRequest = StatusRequest.loading;

  /// 🛒 العناصر داخل السلة
  List<CartItemEntity> cartItems = [];

  /// 🧾 كل المنتجات (من التخزين أو الـ API)
  List<ProductEntity> products = [];

  /// 🧩 المنتجات الموجودة في السلة فقط
  List<ProductEntity> cartProducts = [];

  /// 💰 السعر الإجمالي
  double totalPrice = 0.0;

  @override
  void onInit() async {
    super.onInit();
    loadCart();
  }

  /// 🧾 تحميل عناصر السلة + المنتجات المرتبطة
  Future<void> loadCart() async {
    products.clear();
    statusRequest = StatusRequest.loading;
    update();

    bool hasError = false;

    // 🧠 تحميل المنتجات
    final productsResult = await productLocalUseCase();
    productsResult.fold(
      (error) {
        hasError = true;
      },
      (data) {
        products = data.data ?? [];
      },
    );

    // 🛒 تحميل السلة
    cartItems = await getCartItemsUseCase();
    // 🔗 ربط المنتجات بالسلة
    applyCartFilter();

    // 💰 حساب السعر
    _calculateTotal();
    statusRequest = hasError ? StatusRequest.loading :cartProducts.isEmpty?StatusRequest.nodata: StatusRequest.initial;
    update();
  }

  /// 🔗 تصفية المنتجات لتشمل فقط عناصر السلة
  void applyCartFilter() {
    cartProducts.clear();

    for (final item in cartItems) {
      // ابحث عن المنتج الأصلي
      final product = products.firstWhereOrNull((p) => p.id == item.productId);
      if (product != null) {
        // ابحث عن الـ variant المطابق للقياس واللون
        final color = product.variants
            .firstWhereOrNull(
              (v) => v.color.id == item.colorId,
            )!
            .color;
        final size = product.variants
            .firstWhereOrNull(
              (v) => v.size.id == item.sizeId,
            )!
            .size;
        ProductVariantsEntity variantsEntity =
            ProductVariantsEntity(id: -1, color: color, size: size, price: 0);

        // أنشئ نسخة جديدة من المنتج لكن نحدث الـ variant
        final updatedProduct = ProductEntity(
          id: product.id,
          basePrice: product.basePrice,
          createdAt: product.createdAt,
          productName: product.productName,
          productDescription: product.productDescription,
          category: product.category,
          images: product.images,
          variants: [variantsEntity], // فقط الـ variant المطابق
        );

        cartProducts.add(updatedProduct);
      }
    }

    print("controller${cartProducts.length}");

    _calculateTotal();
    checkData();
    update();
  }

  /// ➕ إضافة عنصر إلى السلة
  Future<void> addToCart(ProductEntity product) async {
    var item = cartItems.firstWhere((c) =>
        c.productId == product.id &&
        c.sizeId == product.variants.first.size.id &&
        c.colorId == product.variants.first.color.id);
    print(item.quantity);
    await addCartItemUseCase(item);
    await loadCart();
  }

  Future<void> removeFromCart(ProductEntity product) async {
    var item = cartItems.firstWhere((c) =>
        c.productId == product.id &&
        c.sizeId == product.variants.first.size.id &&
        c.colorId == product.variants.first.color.id);
    await removeCartItemUseCase(item);
    await loadCart();
  }

  Future<void> minesQuantityFromCart(ProductEntity product) async {
    var item = cartItems.firstWhere((c) =>
        c.productId == product.id &&
        c.sizeId == product.variants.first.size.id &&
        c.colorId == product.variants.first.color.id);
    print(item.quantity);
    await minesQuantityCartUseCase(item);
    await loadCart();
  }

  /// 🧹 تفريغ السلة بالكامل
  Future<void> clearCart() async {
    await clearCartUseCase();
    cartItems.clear();
    cartProducts.clear();
    totalPrice = 0.0;
    checkData();
    update();
  }

  int getQuantity(ProductEntity product) {
    return cartItems
        .firstWhere((c) =>
            c.productId == product.id &&
            c.sizeId == product.variants.first.size.id &&
            c.colorId == product.variants.first.color.id)
        .quantity;
  }

  /// 🧮 حساب السعر الإجمالي
  void _calculateTotal() {
    totalPrice = 0.0;
    for (final item in cartProducts) {
      totalPrice += item.basePrice * getQuantity(item);
      print(totalPrice);
    }
  }
  void checkData(){
    if(cartProducts.isEmpty)
      statusRequest=StatusRequest.nodata;
  }
}
