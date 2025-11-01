import 'package:get/get.dart';

import '../../../domain/use_cases/address/add_address_usecase.dart';
import '../../../domain/use_cases/address/update_address_usecase.dart';
import '../../controllers/setting/option_address_controller.dart';

class OptionAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddAddressUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => UpdateAddressUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => OptionAddressController(Get.find(), Get.find()),fenix: true);
  }
}
