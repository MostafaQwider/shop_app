import 'package:get/get.dart';

import '../../controllers/main_screen_pages/order/order_detail_controller.dart';

class OrderDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailController(),fenix: true);
  }

}