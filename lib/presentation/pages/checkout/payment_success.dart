import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/strings.dart';
import '../../component/app_button.dart';
import '../../routes/app_routes.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(60),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 10,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColorLight,
                ),
                child: SvgPicture.asset(AssetsManager.check),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(AppStrings.paymantSuccessfully.tr,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 10),
          Text(AppStrings.paymentIsTheTransfer.tr,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AppButton(
                  text: AppStrings.backToHome.tr,
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.mainScreenRoute);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
