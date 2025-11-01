import 'package:get/get.dart';
import '../../../domain/use_cases/address/get_address_usecase.dart';
import '../../../domain/use_cases/address/remove_address_usecase.dart';
import '../../controllers/setting/address_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemoveAddressUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetAddressUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => AddressController(Get.find(), Get.find()),fenix: true);
  }
}
