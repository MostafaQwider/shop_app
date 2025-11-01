import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/assets_manager.dart';
import '../../controllers/auth/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child:SvgPicture.asset(AssetsManager.appIcon)
      ),
    );
  }
}
