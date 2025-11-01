import 'package:get/get.dart';
import '../../../domain/use_cases/auth/reset_password_usecase.dart';
import '../../controllers/auth/reset_password_controller.dart';
class ResetPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => ResetPasswordController(Get.find()),fenix: true);
  }

}