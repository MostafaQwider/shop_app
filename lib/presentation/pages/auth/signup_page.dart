import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/strings.dart';
import '../../component/app_button.dart';
import '../../component/handling_data.dart';
import '../../controllers/auth/signup_controller.dart';
import 'component/header_section.dart';
import 'component/signup_action.dart';
import 'component/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(20),
          child: GetBuilder<SignupController>(
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
                      HeaderSection(height: 20, title: AppStrings.signup.tr),
                      const SizedBox(height: 30),

                      SignupForm(controller: controller),
                      const SizedBox(height: 20),

                      // Signup button
                      AppButton(
                        text: AppStrings.signup.tr,
                        onPressed: controller.signup,
                      ),

                      const SizedBox(height: 15),

                      // Already have an account?
                      const SignupAction()
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
