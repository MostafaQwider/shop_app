import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/strings.dart';
import '../../component/handling_data.dart';
import '../../controllers/main_screen_pages/settings_controller.dart';
import '../../routes/app_routes.dart';
import 'component/build_expandable_tile.dart';
import 'component/build_sub_setting_item.dart';
import 'component/user_info.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ربط الـ Controller بالـ View

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: GetBuilder<SettingsController>(builder: (controller) =>
               HandlingData(
                 statusRequest: controller.statusRequest,
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // قسم معلومات المستخدم
                    UserInfo(email: controller.email,name: controller.name,),
                    const SizedBox(height: 20),

                    // قسم إعدادات الحساب
                    Obx(() => BuildExpandableTile(
                          icon: AssetsManager.email,
                          title: 'إعدادات الحساب',
                          isExpanded: controller.isAccountSettingsExpanded.value,
                          onTap: controller.toggleAccountSettings,
                          children: [

                            BuildSubSettingItem(
                                title: 'تغيير كلمة المرور',
                                icon: AssetsManager.lock,
                                onTap: ()=>Get.toNamed(AppRoutes.changePasswordRoute)
                            ),
                            BuildSubSettingItem(
                                title: 'تسجيل الخروج',
                                icon: AssetsManager.logout,
                                onTap: () {
                                  Get.defaultDialog(
                                    title: 'تسجيل الخروج',
                                    middleText:
                                        'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                                    textConfirm: 'نعم',
                                    textCancel: 'إلغاء',
                                    confirmTextColor: Colors.white,
                                    onConfirm: () {
                                      Get.back(); // إغلاق الـ dialog
                                      Get.snackbar(
                                          'تسجيل خروج', 'تم تسجيل الخروج بنجاح');
                                      // قم بتوجيه المستخدم لصفحة تسجيل الدخول
                                      // Get.offAllNamed(Routes.LOGIN);
                                    },
                                  );
                                }),
                          ],
                        )),
                    const SizedBox(height: 10),
                    Card(
                      surfaceTintColor: Theme.of(context).cardColor,
                      child: ListTile(
                        title: Text( AppStrings.deliveryAddress.tr,
                            style: Theme.of(context).textTheme.titleMedium),
                        leading: Icon(
                            color: Theme.of(context).primaryColor,
                            Icons.location_on_outlined),
                        // أيقونة اختيارية بجانب العنوان الرئيسي
                        trailing: Icon(
                            color: Theme.of(context).primaryColor,
                            Icons.arrow_forward,
                            size: 20),
                        onTap: () =>
                           Get.toNamed(AppRoutes.addressRoute),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // قسم تغيير اللغة
                    Obx(() => BuildExpandableTile(
                          icon: AssetsManager.language,
                          title: 'تغيير اللغة',
                          isExpanded: controller.isLanguageSettingsExpanded.value,
                          onTap: controller.toggleLanguageSettings,
                          children: [
                            // عرض اللغات بشكل أفقي
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: controller.availableLanguages.map((lang) {
                                  return Obx(() => ChoiceChip(
                                        label: Text(lang.toUpperCase()),
                                        selected:
                                            controller.selectedLanguage.value ==
                                                lang,
                                        onSelected: (selected) {
                                          if (selected) {
                                            controller.changeLanguage(lang);
                                          }
                                        },
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                        checkmarkColor: controller
                                                    .selectedLanguage.value ==
                                                lang
                                            ? Theme.of(context).colorScheme.surface
                                            : Theme.of(context).primaryColor,
                                        side: BorderSide.none,
                                        selectedColor:
                                            Theme.of(context).primaryColor,
                                        labelStyle: TextStyle(
                                          color:
                                              controller.selectedLanguage.value ==
                                                      lang
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .surface
                                                  : Theme.of(context).primaryColor,
                                        ),
                                      ));
                                }).toList(),
                              ),
                            ),
                          ],
                        )),
                  ],
                               ),
               ),
            ),
          ),
        ),
      ),
    );
  }
}
