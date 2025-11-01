import 'package:get/get.dart';

import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/entities/colors_entity.dart';
import '../../../domain/entities/favorite_entity.dart';
import '../../../domain/entities/product_images_entity.dart';
import '../../../domain/entities/products_entity.dart';
import '../../../domain/entities/sizes_entity.dart';
import '../../../domain/use_cases/cart/add_to_cart_usecase.dart';
import '../../../domain/use_cases/favorite/get_favorites_usecase.dart';
import '../../../domain/use_cases/favorite/toggle_favorite_usecase.dart';
import '../../component/app_snack_bar.dart';
class DetailController extends GetxController {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final AddToCartUseCase addToCartUseCase;

  DetailController(this.toggleFavoriteUseCase,
      this.getFavoritesUseCase,
      this.addToCartUseCase,);

  late ProductEntity product;

  List<SizesEntity> sizes = [];
  List<ColorsEntity> colors = [];
  List<ProductImagesEntity> images = [];

  var selectedSize = 0.obs;
  var selectedColor = 0.obs;
  var isFavorite = false.obs;
  RxList<int> favoriteProductIds = <int>[].obs;

  // -------------------------
  // تحميل البيانات الأساسية
  // -------------------------
  void loadSizes() {
    sizes = product.variants.map((v) => v.size).toSet().toList();
  }

  void loadColors() {
    colors = product.variants.map((v) => v.color).toSet().toList();
  }

  void loadImages() {
    images = product.images;
  }

  // -------------------------
  // التعامل مع المفضلة
  // -------------------------
  Future<void> loadFavorites() async {
    final favorites = await getFavoritesUseCase();
    favoriteProductIds.value = favorites.map((f) => f.productId).toList();
    isFavorite.value = favoriteProductIds.contains(product.id);
  }

  Future<void> toggleFavorite() async {
    final entity = FavoriteEntity(productId: product.id);
    await toggleFavoriteUseCase(entity);
    await loadFavorites(); // إعادة التحميل لتحديث الحالة
  }

  // -------------------------
  // التعامل مع السلة
  // -------------------------
  Future<void> addToCart() async {
    if (selectedSize.value == 0 || selectedColor.value == 0) {
      Get.snackbar("اختيار ناقص", "يرجى تحديد اللون والمقاس");
      return;
    }

    final cartItem = CartItemEntity(
      productId: product.id,
      colorId: selectedColor.value,
      sizeId: selectedSize.value,
      quantity: 1,
    );

    await addToCartUseCase(cartItem);
    showToastMessage(label: "", text: "تمت إضافة المنتج إلى السلة بنجاح");
  }

  // -------------------------
  // اختيارات المستخدم
  // -------------------------
  void setSize(int id) => selectedSize.value = id;

  void setColor(int id) => selectedColor.value = id;

  // -------------------------
  // دورة الحياة
  // -------------------------
  @override
  void onInit() {
    super.onInit();
    product = Get.arguments['product'] as ProductEntity;
    loadSizes();
    loadColors();
    loadImages();
    loadFavorites();

    if (sizes.isNotEmpty) selectedSize.value = sizes[0].id;
    if (colors.isNotEmpty) selectedColor.value = colors[0].id;
  }
}
