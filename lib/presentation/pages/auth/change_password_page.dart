import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/user_input_validation.dart';
import '../../component/app_button.dart';
import '../../component/app_text_form_field.dart';
import '../../component/handling_data.dart';
import '../../controllers/auth/change_password_controller.dart';
import '../../controllers/auth/forget_password_controller.dart';
import 'component/header_section.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(20),
          child: GetBuilder<ChangePasswordController>(
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
                      HeaderSection(height: 80, title: AppStrings.changePassword.tr),


                      const SizedBox(height: 30),

                      // Email
                      AppTextFormField(
                        hintText: AppStrings.oldPassword.tr,
                        icon: Icons.lock_open,
                        controller: controller.oldPassword,
                        validator: (val) =>userInputValidation(val!, 8, 50, "password"),
                        isNumeric: false,
                      ),

                      const SizedBox(height: 20),
                      AppTextFormField(
                        hintText: AppStrings.newPassword.tr,
                        icon: Icons.lock_open,
                        controller: controller.newPassword,
                        validator: (val) =>userInputValidation(val!, 8, 50, "password"),
                        isNumeric: false,
                      ),

                      const SizedBox(height: 20),

                      // Reset button
                      AppButton(
                        text: AppStrings.save.tr,
                        onPressed: controller.changePassword,
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
