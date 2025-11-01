import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/user_input_validation.dart';
import '../../component/app_button.dart';
import '../../component/app_text_form_field.dart';
import '../../component/handling_data.dart';
import '../../controllers/auth/forget_password_controller.dart';
import 'component/header_section.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(20),
          child: GetBuilder<ForgetPasswordController>(
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
                      HeaderSection(height: 80, title: AppStrings.forgetPasswordPage.tr),


                      const SizedBox(height: 30),

                      // Email
                      AppTextFormField(
                        hintText: AppStrings.email.tr,
                        icon: Icons.email,
                        controller: controller.emailController,
                        validator: (val) =>userInputValidation(val!, 8, 50, "email"),
                        isNumeric: false,
                      ),

                      const SizedBox(height: 20),

                      // Reset button
                      AppButton(
                        text: AppStrings.send.tr,
                        onPressed: controller.sendEmail,
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
