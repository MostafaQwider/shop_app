import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utils/user_input_validation.dart';
import '../../../component/app_text_form_field.dart';
import '../../../controllers/auth/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.controller});
  final LoginController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        AppTextFormField(
          hintText: AppStrings.email.tr,
          icon: Icons.email,
          controller: controller.emailController,
          validator: (val) =>
              userInputValidation(val!, 8, 50, "email"),
          isNumeric: false,
        ),

        // Password
        AppTextFormField(
          hintText: AppStrings.password.tr,
          icon: controller.isPasswordVisible
              ? Icons.visibility_off
              : Icons.visibility,
          controller: controller.passwordController,
          validator: (val) =>
              userInputValidation(val!, 2, 20, "password"),
          isNumeric: false,
          obscureText: controller.isPasswordVisible,
          onIconTap: controller.togglePasswordVisibility,
        ),
      ],
    );
  }
}
