import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/entities/order_items_entity.dart';
import '../../../domain/entities/orders_entity.dart';
import '../../../domain/entities/products_entity.dart';
import '../../../domain/use_cases/address/get_address_usecase.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/use_cases/cart/clear_cart_usecase.dart';
import '../../../domain/use_cases/orders/add_orders_usecase.dart';
import '../../component/app_snack_bar.dart';

class CheckoutController extends GetxController {
  GetAddressUseCase getAddressUseCase;
  AddOrderUseCase addOrderUseCase;
  ClearCartUseCase clearCartUseCase ;

  CheckoutController(this.getAddressUseCase, this.addOrderUseCase,this.clearCartUseCase);

  /// المتغيرات
  int addressCheckID = 0;
  List<AddressEntity> address = [];
  List<ProductEntity> products = [];
  List<CartItemEntity> cartItems = [];
  double subTotal = 0.0;
  StatusRequest statusRequest = StatusRequest.loading;

  @override
  void onInit() async {
    super.onInit();
    products = Get.arguments['product'];
    cartItems = Get.arguments['cartItems'];
    subTotal = Get.arguments['subTotal'];

    await getSavedAddress();
  }

  /// الحصول على العناوين المحفوظة
  Future<void> getSavedAddress() async {
    address.clear();
    final result = await getAddressUseCase();
    result.fold((error) => null, (data) => address.addAll(data.data!));
    addressCheckID = address.first.id!;
    statusRequest = StatusRequest.initial;
    update();
  }

  void setAddress(int i) {
    addressCheckID == i ? 0 : addressCheckID = i;
    update();
  }

  bool isSelectedAddress(int id) => id == addressCheckID;

  /// تكلفة التوصيل
  double get deliveryFee => 3.00;

  /// قيمة الضريبة أو الرسوم
  double get fax => 2.120;

  /// حساب السعر الكلي النهائي
  double getPriceTotal() {
    return deliveryFee + (subTotal + fax);
  }

  int getQuantity(ProductEntity p) {
    return cartItems
        .firstWhere((e) =>
            e.colorId == p.variants.first.color.id &&
            e.sizeId == p.variants.first.size.id &&
            e.productId == p.id)
        .quantity;
  }

  Future<void> addOrder() async {
    statusRequest = StatusRequest.loading;
    update();
    final items = cartItems
        .map((e) => OrderItemsEntity(
            color_id: e.colorId,
            product_id: e.productId,
            size_id: e.sizeId,
            quantity: e.quantity,
            price: products
                .firstWhere((element) => element.id == e.productId)
                .basePrice))
        .toList();
    final order = OrdersEntity(
        total: getPriceTotal(), address_id: addressCheckID, items: items);
    final result = await addOrderUseCase(order);
    await clearCartUseCase();
    result.fold((error) => showToastMessage(label: "", text: error),
        (data) => showToastMessage(label: "", text: data.message!));
    statusRequest = StatusRequest.initial;
    update();
  }
}
