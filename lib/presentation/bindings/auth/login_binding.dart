import 'package:get/get.dart';
import '../../../domain/use_cases/auth/login_usecase.dart';
import '../../controllers/auth/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => LoginController(Get.find()),fenix: true);
  }
}
