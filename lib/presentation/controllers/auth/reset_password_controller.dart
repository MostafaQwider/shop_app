import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/use_cases/auth/reset_password_usecase.dart';
import '../../component/app_snack_bar.dart';
import '../../routes/app_routes.dart';

class ResetPasswordController extends GetxController {
  ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordController(this.resetPasswordUseCase);
  String email="";
  @override
  void onInit() {
    super.onInit();
    email=Get.arguments['email'];
  }
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.initial;

  Future<void> reset() async {
    if (formKey.currentState!.validate()) {
      statusRequest=StatusRequest.loading;
      update();
      final result =
      await resetPasswordUseCase(email:email,newPassword: passwordController.text.trim());
      result.fold((l) => showToastMessage(label: '',text: l),
              (r)  {
            showToastMessage(label: '',text: r.message??"");
            if(r.status==StatusRequest.success){
              Get.offNamed(AppRoutes.loginRoute);
            }
          });
      statusRequest=StatusRequest.initial;
      update();
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
