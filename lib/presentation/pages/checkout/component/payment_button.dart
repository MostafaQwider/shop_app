import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../controllers/checkout/checkout_controller.dart';

class SwipePaymentButton extends StatelessWidget {
  final CheckoutController controller;

  const SwipePaymentButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final slideActionKey = GlobalKey<SlideActionState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SlideAction(
        key: slideActionKey,
        height: 50, // تقليل ارتفاع الزر
        text: AppStrings.swipeForPayment.tr,
        textStyle: const TextStyle(
            color: AppColor.white, fontWeight: FontWeight.bold, fontSize: 14),
        sliderButtonIcon: const Icon(
          Icons.arrow_forward,
          color: AppColor.orange,
          size: 20, // تصغير أيقونة السحب
        ),
        sliderRotate: false,
        outerColor: AppColor.orange,
        innerColor: AppColor.white,
        sliderButtonIconPadding: 10,
        onSubmit: () async{
          Future.delayed(const Duration(milliseconds: 500), () {
            slideActionKey.currentState?.reset();
          });
          await controller.addOrder();

        },
      ),
    );
  }
}
