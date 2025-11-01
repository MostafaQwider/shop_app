import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../core/constants/strings.dart';
import '../controllers/main_screen_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainScreenController());

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Obx(() => controller.pages[controller.index]),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Obx(
                () => GNav(
              rippleColor: theme.primaryColor.withOpacity(0.2),
              hoverColor: theme.primaryColor.withOpacity(0.1),
              gap: 4,
              activeColor: theme.colorScheme.onPrimary,
              iconSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: theme.primaryColor,
              color: theme.iconTheme.color,
              selectedIndex: controller.index,
              onTabChange: (i) => controller.index = i,
              tabs:  [
                GButton(icon: CupertinoIcons.home, text: AppStrings.home.tr),
                GButton(icon: CupertinoIcons.heart, text: AppStrings.myFavorites.tr),
                GButton(icon: CupertinoIcons.shopping_cart, text: AppStrings.myCart.tr),
                GButton(icon: CupertinoIcons.arrow_up_bin, text: AppStrings.myOrders.tr),
                GButton(icon: Icons.settings_outlined, text: AppStrings.settings.tr),
              ],
            ),
          ),
        ),
      ),
    );
  }
}