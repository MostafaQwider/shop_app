import 'package:get/get.dart';

import '../../../domain/use_cases/auth/change_password_usecase.dart';
import '../../controllers/auth/change_password_controller.dart';
class ChangePasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => ChangePasswordController(Get.find()),fenix: true);
  }

}