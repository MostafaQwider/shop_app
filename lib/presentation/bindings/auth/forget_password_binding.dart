import 'package:get/get.dart';

import '../../../domain/use_cases/auth/send_reset_code_usecase.dart';
import '../../controllers/auth/forget_password_controller.dart';
class ForgetPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SendResetCodeUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => ForgetPasswordController(Get.find()),fenix: true);
  }

}