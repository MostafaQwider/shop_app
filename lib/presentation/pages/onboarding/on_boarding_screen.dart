import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../controllers/onboarding/on_boarding_controller.dart';
import 'component/on_boarding_pageview.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Row(
                    children: [
                      Text(
                        '${controller.pageIndex.value + 1}',
                        style: const TextStyle(color: AppColor.black),
                      ),
                      Text(
                        '/${controller.onBoardingList.length}',
                        style: TextStyle(
                          color: controller.pageIndex.value ==
                              controller.onBoardingList.length - 1
                              ? Colors.black
                              : Colors.black54,
                        ),
                      ),
                    ],
                  )),
                  InkWell(
                    onTap: controller.skipButton,
                    child: const Text(
                      AppStrings.skip,
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 55),
              const OnBoardingPageView(),
              const SizedBox(height: 30),
              Obx(
                    () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 79, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    backgroundColor: AppColor.orange,
                  ),
                  onPressed: controller.nextButton,
                  child: Text(
                    controller.buttonText,
                    style: const TextStyle(
                      color: AppColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
