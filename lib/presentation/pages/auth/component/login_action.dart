import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/strings.dart';
import '../../../routes/app_routes.dart';

class LoginAction extends StatelessWidget {
  const LoginAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAccount.tr,
        ),
        const Text(":"),
        GestureDetector(
          onTap: () {
            Get.offNamed(AppRoutes.signupRoute);
          },
          child: Text(
            AppStrings.signup.tr,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
