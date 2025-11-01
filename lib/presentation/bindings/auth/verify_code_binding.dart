import 'package:get/get.dart';

import '../../../domain/use_cases/auth/verify_account_usecase.dart';
import '../../../domain/use_cases/auth/verify_reset_code_usecase.dart';
import '../../controllers/auth/verify_code_controller.dart';

class VerifyCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>VerifyAccountUseCase(Get.find()),fenix:true);
    Get.lazyPut(()=>VerifyResetCodeUseCase(Get.find()),fenix:true);
    Get.lazyPut(() => VerifyCodeController(Get.find(),Get.find()), fenix: true);
  }
}
