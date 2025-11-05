import 'package:get/get.dart';
import '../../../domain/use_cases/orders/update_orders_usecase.dart';
import '../../../domain/use_cases/payment/payment_config_usecase.dart';
import '../../../domain/use_cases/address/get_address_usecase.dart';
import '../../../domain/use_cases/cart/clear_cart_usecase.dart';
import '../../../domain/use_cases/orders/add_orders_usecase.dart';
import '../../controllers/checkout/checkout_controller.dart';

class CheckOutBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => GetAddressUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => AddOrderUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => ClearCartUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => PaymentConfigUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => UpdateOrderUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => CheckoutController(Get.find(),Get.find(),Get.find(),Get.find(),Get.find()),fenix: true);
  }

}