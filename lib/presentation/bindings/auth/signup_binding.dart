import 'package:get/get.dart';
import '../../../domain/use_cases/auth/register_usecase.dart';
import '../../controllers/auth/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => SignupController(Get.find()),fenix: true);
  }
}
