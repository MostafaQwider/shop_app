import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/assets_manager.dart';

import '../../../core/constants/strings.dart';
import '../../../core/services/storage_service.dart';
import '../../routes/app_routes.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  final StorageService _storage = StorageService();

  var pageIndex = 0.obs;

  final List<OnboardingInput> onBoardingList = [
    OnboardingInput(
      title: AppStrings.onBoardingTitle1,
      description: AppStrings.onBoardingDescription1,
      image: AssetsManager.onBoarding1,
    ),
    OnboardingInput(
      title: AppStrings.onBoardingTitle2,
      description: AppStrings.onBoardingDescription2,
      image: AssetsManager.onBoarding2,
    ),
    OnboardingInput(
      title: AppStrings.onBoardingTitle3,
      description: AppStrings.onBoardingDescription3,
      image: AssetsManager.onBoarding3,
    ),
  ];

  String get buttonText =>
      pageIndex.value == 2 ? AppStrings.getStarted : AppStrings.next;

  void onPageChange(int index) {
    pageIndex.value = index;
  }

  void nextButton() {
    if (pageIndex.value < onBoardingList.length - 1) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    } else {
      goToAuth();
    }
  }

  void skipButton() {
    goToAuth();
  }

  void goToAuth() {
    Get.offAllNamed(AppRoutes.loginRoute);
  }

  Future<void> completeOnBoarding() async {
    await _storage.write(key: "isOnBoardingComplete", value: true);
  }

  @override
  void onInit() {
    completeOnBoarding();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingInput {
  final String title;
  final String description;
  final String image;

  OnboardingInput({
    required this.title,
    required this.description,
    required this.image,
  });
}
