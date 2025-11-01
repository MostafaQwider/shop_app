import 'package:get/get.dart';

import '../../controllers/onboarding/on_boarding_controller.dart';

class OnBoardingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardingController(),fenix: true);
  }

}