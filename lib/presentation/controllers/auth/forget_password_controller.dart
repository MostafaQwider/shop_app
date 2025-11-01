import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/use_cases/auth/send_reset_code_usecase.dart';
import '../../component/app_snack_bar.dart';
import '../../routes/app_routes.dart';

class ForgetPasswordController extends GetxController {
  SendResetCodeUseCase sendResetCodeUseCase;

  ForgetPasswordController(this.sendResetCodeUseCase);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.initial;

  Future<void> sendEmail() async {
    if (formKey.currentState!.validate()) {
      statusRequest=StatusRequest.loading;
      update();
      final result =
          await sendResetCodeUseCase(email: emailController.text.trim());
      result.fold((l) => showToastMessage(label: '',text: l),
              (r)  {
                showToastMessage(label: '',text: r.message??"");
                if(r.status==StatusRequest.success){
                  Get.offNamed(AppRoutes.verifyCodeRoute,arguments:{
                    "type":"forgetPassword",
                    "email":emailController.text.trim()
                  });
                }
              });
      statusRequest=StatusRequest.initial;
      update();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
