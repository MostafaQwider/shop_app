import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/strings.dart';
import '../../component/app_button.dart';
import '../../component/handling_data.dart';
import '../../controllers/auth/login_controller.dart';
import '../../routes/app_routes.dart';
import 'component/header_section.dart';
import 'component/login_action.dart';
import 'component/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          child: GetBuilder<LoginController>(
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
                      HeaderSection(height: 20, title: AppStrings.login.tr),
                      const SizedBox(height: 30),

                      LoginForm(controller: controller),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.forgetPasswordRoute);
                          },
                          child: Text(
                            AppStrings.forgetPassword.tr,
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      const SizedBox(height: 20),

                      // Signup button
                      AppButton(
                        text: AppStrings.login.tr,
                        onPressed: controller.login,
                      ),

                      const SizedBox(height: 15),

                      // Already have an account?
                      LoginAction(
                        onTap: controller.continueAsAGuest,
                      )
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
