import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../component/app_button.dart';
import '../../../core/constants/strings.dart';
import '../../component/handling_data.dart';
import '../../controllers/auth/verify_code_controller.dart';
import 'component/header_section.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<VerifyCodeController>(
          builder: (controller) => HandlingData(
            statusRequest: controller.statusRequest,
            child: Container(
              height: Get.height,
              width: Get.width,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    HeaderSection(
                        height: 80,
                        title: controller.type == "register"
                            ? AppStrings.verifyAccount.tr
                            : AppStrings.verifyResetPassword.tr),

                    const SizedBox(height: 30),

                    // OTP Input
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(

                        length: 6,
                        showCursor: true,

                        onCompleted: (pin) => controller.otpCode = pin,
                        onChanged: (value) => controller.otpCode = value,
                        defaultPinTheme: PinTheme(

                          width: 50,
                          height: 60,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.primaryColor),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Verify Button
                    AppButton(
                      text: AppStrings.verify.tr,
                      onPressed: controller.verifyOtp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
