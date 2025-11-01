import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/enums.dart';
import '../../../core/constants/strings.dart';
import '../../../domain/use_cases/auth/verify_account_usecase.dart';
import '../../../domain/use_cases/auth/verify_reset_code_usecase.dart';
import '../../component/app_snack_bar.dart';
import '../../routes/app_routes.dart';

class VerifyCodeController extends GetxController {
  VerifyAccountUseCase verifyAccountUseCase;
  VerifyResetCodeUseCase verifyResetCodeUseCase;

  VerifyCodeController(this.verifyResetCodeUseCase, this.verifyAccountUseCase);

  final formKey = GlobalKey<FormState>();

  /// نوع الاستخدام (register / forgetPassword)
  String type = "register";
  StatusRequest statusRequest = StatusRequest.initial;

  /// النص المدخل
  String otpCode = "";
  String email = "";

  @override
  void onInit() {
    super.onInit();
    type = Get.arguments['type'];
    email = Get.arguments['email']??"";
  }

  void verifyOtp() async {
    if (otpCode.length == 6) {
      statusRequest = StatusRequest.loading;
      update();
      if (type == "register") {
        final result = await verifyAccountUseCase(code: otpCode, email: email);
        result.fold((l) => showToastMessage(label: '', text: l), (r) {
          showToastMessage(label: '', text: r.message ?? "");
          Get.offAllNamed(AppRoutes.mainScreenRoute);
        });
      } else if (type == "forgetPassword") {
        final result =
            await verifyResetCodeUseCase(code: otpCode, email: email);
        result.fold((l) => showToastMessage(label: '', text: l), (r) {
          showToastMessage(label: '', text: r.message ?? "");
          Get.offAllNamed(AppRoutes.resetPasswordRoute,arguments: {"email":email});
        });
      }
      statusRequest=StatusRequest.initial;
    } else {
      showToastMessage(label: '', text: AppStrings.pleaseFillTheField.tr);
    }
    update();
  }
}
