import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/entities/users_entity.dart';
import '../../../domain/use_cases/auth/register_usecase.dart';
import '../../component/app_snack_bar.dart';
import '../../routes/app_routes.dart';

class SignupController extends GetxController {
  final RegisterUseCase signupUseCase;

  SignupController(this.signupUseCase);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool isPasswordVisible = false;
  StatusRequest statusRequest = StatusRequest.initial;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void goToLogin() {
    Get.offNamed(AppRoutes.loginRoute);
  }

  Future<void> signup() async {
    if (!formKey.currentState!.validate()) return;

    statusRequest = StatusRequest.loading;
    update();

    final result = await signupUseCase(
        user: UsersEntity(
            name: nameController.text,
            email: emailController.text.trim(),
            password: passwordController.text.trim()));
    statusRequest = StatusRequest.initial;

    result.fold(
      (error) {
        showToastMessage(text: error, label: '');
      },
      (user) {
        showToastMessage(
            text: user.message ?? "user signup successfully", label: '');
        if(user.status==StatusRequest.success){
          Get.offNamed(AppRoutes.verifyCodeRoute,arguments:{
            "type":"register",
            "email":emailController.text.trim()
          });
        }
      },
    );
    update();
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
