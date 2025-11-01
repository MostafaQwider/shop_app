import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/strings.dart';
import '../../../routes/app_routes.dart';

class SignupAction extends StatelessWidget {
  const SignupAction({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.alreadyHaveAccount.tr,
        ),
        GestureDetector(
          onTap: () {
            Get.offNamed(AppRoutes.loginRoute);
          },
          child: Text(
            AppStrings.login.tr,
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
