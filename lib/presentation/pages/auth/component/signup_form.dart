import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utils/user_input_validation.dart';
import '../../../component/app_text_form_field.dart';
import '../../../controllers/auth/signup_controller.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key, required this.controller});
 final  SignupController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full Name
        AppTextFormField(
          hintText: AppStrings.username.tr,
          icon: Icons.person,
          controller: controller.nameController,
          validator: (val) =>
              userInputValidation(val!, 2, 20, "username"),
          isNumeric: false,
        ),

        // Email
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
