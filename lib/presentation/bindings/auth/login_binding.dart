import 'package:get/get.dart';
import '../../../domain/use_cases/auth/continue_as_aguest_usecase.dart';
import '../../../domain/use_cases/auth/login_usecase.dart';
import '../../../domain/use_cases/auth/send_verify_code_usecase.dart';
import '../../controllers/auth/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => SendVerifyCodeUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => ContinueAsAGuestUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => LoginController(Get.find(),Get.find(),Get.find()),fenix: true);
  }
}
