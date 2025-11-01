import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/user_input_validation.dart';
import '../../component/app_button.dart';
import '../../component/app_text_form_field.dart';
import '../../component/handling_data.dart';
import '../../controllers/auth/forget_password_controller.dart';
import '../../controllers/auth/reset_password_controller.dart';
import 'component/header_section.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(20),
          child: GetBuilder<ResetPasswordController>(
            builder: (controller) => HandlingData(
              statusRequest: controller.statusRequest,
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      HeaderSection(height: 80, title: AppStrings.resetPassword.tr),


                      const SizedBox(height: 30),

                      // Email
                      AppTextFormField(
                        hintText: AppStrings.password.tr,
                        icon: Icons.lock,
                        controller: controller.passwordController,
                        validator: (val) =>userInputValidation(val!, 8, 50, "password"),
                        isNumeric: false,
                      ),

                      const SizedBox(height: 20),

                      // Reset button
                      AppButton(
                        text: AppStrings.resetPassword.tr,
                        onPressed: controller.reset,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
