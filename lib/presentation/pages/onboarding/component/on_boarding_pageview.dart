import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/onboarding/on_boarding_controller.dart';
import 'on_boarding_widget.dart';
class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnBoardingController>();

    return SizedBox(
      height: Get.height * 0.6,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: controller.onPageChange,
        itemCount: controller.onBoardingList.length,
        itemBuilder: (context, index) {
          final item = controller.onBoardingList[index];
          return OnBoardingWidget(
            title: item.title,
            description: item.description,
            image: item.image,
          );
        },
      ),
    );
  }
}
