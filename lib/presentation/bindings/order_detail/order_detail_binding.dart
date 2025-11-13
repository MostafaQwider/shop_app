import 'package:get/get.dart';

import '../../../domain/use_cases/orders/update_orders_usecase.dart';
import '../../../domain/use_cases/payment/payment_config_usecase.dart';
import '../../controllers/main_screen_pages/order/order_detail_controller.dart';

class OrderDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentConfigUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => UpdateOrderUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => OrderDetailController(Get.find(),Get.find()),fenix: true);
  }

}