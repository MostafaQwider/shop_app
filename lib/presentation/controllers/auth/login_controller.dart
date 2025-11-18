import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/use_cases/auth/continue_as_aguest_usecase.dart';
import '../../../domain/use_cases/auth/login_usecase.dart';
import '../../../domain/use_cases/auth/send_verify_code_usecase.dart';
import '../../component/app_snack_bar.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;
  final SendVerifyCodeUseCase sendVerifyCodeUseCase;
  final ContinueAsAGuestUseCase continueAsAGuestUseCase;

  LoginController(this.loginUseCase, this.continueAsAGuestUseCase, this.sendVerifyCodeUseCase);

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
    statusRequest = StatusRequest.initial;

    result.fold(
          (error) {
        showToastMessage(text: error, label: '');
      }, (user) async {
        showToastMessage(
            text: user.message ?? "user login successfully", label: '');
        //if (!user.data!.user.isVerified!) {
        if (false) {
          final sendResult = await sendVerifyCodeUseCase(
              email: emailController.text);
          sendResult.fold((l) => null, (r) =>
              Get.offAllNamed(AppRoutes.verifyCodeRoute, arguments: {
                "type": "register",
                "email": emailController.text.trim()
              }));
        } else {
          Get.offAllNamed(AppRoutes.mainScreenRoute);
        }
      },
    );
    update();

  }

  void goToSignUp() {
    Get.offNamed(AppRoutes.signupRoute);
  }
  Future<void> continueAsAGuest() async{
    await continueAsAGuestUseCase();
    Get.offNamed(AppRoutes.mainScreenRoute);
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
