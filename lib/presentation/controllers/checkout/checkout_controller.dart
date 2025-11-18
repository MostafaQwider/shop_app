import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/strings.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/entities/order_items_entity.dart';
import '../../../domain/entities/orders_entity.dart';
import '../../../domain/entities/products_entity.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/entities/payment_config_entity.dart';
import '../../../domain/use_cases/address/get_address_usecase.dart';
import '../../../domain/use_cases/cart/clear_cart_usecase.dart';
import '../../../domain/use_cases/orders/add_orders_usecase.dart';
import '../../../domain/use_cases/orders/update_orders_usecase.dart';
import '../../../domain/use_cases/payment/payment_config_usecase.dart';
import '../../component/app_snack_bar.dart';
import '../../routes/app_routes.dart';

class CheckoutController extends GetxController {
  final GetAddressUseCase getAddressUseCase;
  final AddOrderUseCase addOrderUseCase;
  final UpdateOrderUseCase updateOrderUseCase;
  final ClearCartUseCase clearCartUseCase;
  final PaymentConfigUseCase paymentConfigUseCase;

  CheckoutController(
    this.getAddressUseCase,
    this.addOrderUseCase,
    this.updateOrderUseCase,
    this.clearCartUseCase,
    this.paymentConfigUseCase,
  );

  int addressCheckID = -1;
  List<AddressEntity> address = [];
  List<ProductEntity> products = [];
  List<CartItemEntity> cartItems = [];
  double subTotal = 0.0;
  StatusRequest statusRequest = StatusRequest.loading;
  late PaymentConfigEntity paymentConfigEntity;

  @override
  void onInit() async {
    super.onInit();
    products = Get.arguments['product'];
    cartItems = Get.arguments['cartItems'];
    subTotal = Get.arguments['subTotal'];
    await loadData();
    statusRequest = StatusRequest.initial;
    update();
  }

  Future<void> loadData() async {
    await getSavedAddress();
    await getPaymentConfig();
  }

  Future<void> getSavedAddress() async {
    address.clear();
    statusRequest=StatusRequest.loading;
    update();
    final result = await getAddressUseCase();
    result.fold((error) => null, (data) => address.addAll(data.data!));
    if (address.isNotEmpty) {
      addressCheckID = address.first.id!;
    }
    statusRequest=StatusRequest.initial;
    update();

  }

  Future<void> getPaymentConfig() async {
    final result = await paymentConfigUseCase();
    result.fold((error) => null, (data) => paymentConfigEntity = data.data);
  }

  void setAddress(int i) {
    addressCheckID = i;
    update();
  }

  bool isSelectedAddress(int id) => id == addressCheckID;

  double get deliveryFee => 3.00;

  double get fax => 2.120;

  double getPriceTotal() {
    return deliveryFee + (subTotal + fax);
  }

  int getQuantity(ProductEntity p) {
    return cartItems
        .firstWhere(
          (e) =>
              e.colorId == p.variants.first.color.id &&
              e.sizeId == p.variants.first.size.id &&
              e.productId == p.id,
        )
        .quantity;
  }

  /// إنشاء الطلب وتنفيذ الدفع
  Future<void> addOrder() async {
    if(addressCheckID==-1){
      showToastMessage(label: "", text: AppStrings.youMustHaveAtLeastOneAddress.tr);
      return;
    }
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
                  .basePrice,
            ))
        .toList();

    final order = OrdersEntity(
      total: getPriceTotal(),
      address_id: addressCheckID,
      items: items,
    );

    final result = await addOrderUseCase(order);

    result.fold(
      (error) => showToastMessage(label: '', text: error),
      (data) async {
        showToastMessage(label: "", text: data.message!);

        if (data.status == StatusRequest.success) {
          final orderId = data.data!;
          await clearCartUseCase();
          print(paymentConfigEntity.clientId);
          print(paymentConfigEntity.secretKey);

          /// تنفيذ عملية الدفع مباشرة بدون زر
          final paymentResult = await Get.toNamed(
            AppRoutes.paymentRoute,
            arguments: {
              'orderId': orderId,
            },
          );
          // التحقق من نتيجة الدفع وتحديث الطلب
          if (paymentResult != null && paymentResult['status'] == 'success') {
            final transactionId = paymentResult['transactionId'];
            updateOrder(orderId, transactionId, items);
            Get.offNamed(AppRoutes.paymentSuccessRoute);
          } else {
            showToastMessage(
                label: "Payment Failed",
                text: "Payment was cancelled or failed.");
          }
        }
      },
    );

    statusRequest = StatusRequest.initial;
    update();
  }
  List<Map<String, dynamic>> getItems() {
    return products.map((product) {
      return {
        "name": product.productName,
        "quantity":getQuantity(product),
        "price": product.basePrice.toStringAsFixed(2),
        "currency": "USD",
      };
    }).toList();
  }
  Future<void>updateOrder(orderId,transactionId,items)async{
    final updatedOrder = OrdersEntity(
      id: orderId,
      address_id: addressCheckID,
      total: getPriceTotal(),
      items: items,
      payment_method: "paypal",
      expected_delivery_time: "Not Assigned",
      payment_transaction_id: transactionId,
      status: "paid",
    );

    final updateResult = await updateOrderUseCase(updatedOrder);
    updateResult.fold(
          (error) => showToastMessage(label: "", text: error),
          (res) {
        showToastMessage(
            label: "", text: AppStrings.paymantSuccessfully.tr);
      },
    );
  }
}
