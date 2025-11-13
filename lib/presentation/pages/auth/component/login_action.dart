import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/strings.dart';
import '../../../routes/app_routes.dart';

class LoginAction extends StatelessWidget {
  const LoginAction({super.key, required this.onTap});
 final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
        ),
        SizedBox(height: 8,),
        GestureDetector(
          onTap: onTap,
          child: Text(
            AppStrings.continueAsGuest.tr,
            style: Theme.of(context).textTheme.displaySmall
          ),
        ),
      ],
    );
  }
}
