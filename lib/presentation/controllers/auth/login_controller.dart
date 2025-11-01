import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/use_cases/auth/login_usecase.dart';
import '../../component/app_snack_bar.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool isPasswordVisible = false;
  StatusRequest statusRequest = StatusRequest.initial;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    statusRequest = StatusRequest.loading;
    update();

    final result = await loginUseCase(
      email: emailController.text,
      password: passwordController.text,
    );

    result.fold(
      (error) {
        showToastMessage(text: error, label: '');
        statusRequest = StatusRequest.failure;
        update();
      },
      (user) {
        statusRequest = user.status;
        showToastMessage(
            text: user.message ?? "user login successfully", label: '');
        print(user.data!.user.isVerified);
        if (!user.data!.user.isVerified!) {
          Get.offAllNamed(AppRoutes.verifyCodeRoute, arguments: {
            "type": "register",
            "email": emailController.text.trim()
          });
        } else {
          Get.offAllNamed(AppRoutes.mainScreenRoute);
        }
        update();
      },
    );
  }

  void goToSignUp() {
    Get.offNamed(AppRoutes.signupRoute);
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
