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
import '../../component/app_dialog.dart'; // ✅ استدعاء مربع الحوار

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: GetBuilder<SettingsController>(
              builder: (controller) => HandlingData(
                statusRequest: controller.statusRequest,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ✅ معلومات المستخدم
                    UserInfo(email: controller.email, name: controller.name),
                    const SizedBox(height: 20),

                    // ✅ إعدادات الحساب
                    Obx(() => BuildExpandableTile(
                      icon: AssetsManager.email,
                      title: 'إعدادات الحساب',
                      isExpanded:
                      controller.isAccountSettingsExpanded.value,
                      onTap: controller.toggleAccountSettings,
                      children: [
                        BuildSubSettingItem(
                          title: 'تغيير كلمة المرور',
                          icon: AssetsManager.lock,
                          onTap: () => Get.toNamed(
                            AppRoutes.changePasswordRoute,
                          ),
                        ),

                        // ✅ تسجيل الخروج باستخدام AppDialog
                        BuildSubSettingItem(
                          title: 'تسجيل الخروج',
                          icon: AssetsManager.logout,
                          onTap: () {
                            Get.dialog(
                              AppDialog(
                                message:
                                'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                                cancelText: 'إلغاء',
                                confirmText: 'تأكيد',
                                onCancel: () => Get.back(),
                                onConfirm: () {
                                  Get.back(); // إغلاق مربع الحوار
                                  controller.logout(); // استدعاء دالة تسجيل الخروج من الكنترولر
                                  Get.snackbar('تسجيل الخروج',
                                      'تم تسجيل الخروج بنجاح');
                                  Get.offAllNamed(AppRoutes.loginRoute);
                                },
                              ),
                              barrierDismissible: false,
                            );
                          },
                        ),
                      ],
                    )),
                    const SizedBox(height: 10),

                    // ✅ العنوان والتوصيل
                    Card(
                      surfaceTintColor: Theme.of(context).cardColor,
                      child: ListTile(
                        title: Text(
                          AppStrings.deliveryAddress.tr,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        leading: Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () => Get.toNamed(AppRoutes.addressRoute),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ✅ تغيير اللغة باستخدام AppDialog
                    Obx(() => BuildExpandableTile(
                      icon: AssetsManager.language,
                      title: 'تغيير اللغة',
                      isExpanded:
                      controller.isLanguageSettingsExpanded.value,
                      onTap: controller.toggleLanguageSettings,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children:
                            controller.availableLanguages.map((lang) {
                              return Obx(
                                    () => ChoiceChip(
                                  label: Text(lang.toUpperCase()),
                                  selected: controller
                                      .selectedLanguage.value ==
                                      lang,
                                  onSelected: (selected) {
                                    if (selected) {
                                      // 🟢 تأكيد تغيير اللغة قبل التنفيذ
                                      Get.dialog(
                                        AppDialog(
                                          message:
                                          "هل ترغب بتغيير اللغة إلى ${lang.toUpperCase()}؟",
                                          cancelText: "إلغاء",
                                          confirmText: "تأكيد",
                                          onCancel: () => Get.back(),
                                          onConfirm: () {
                                            Get.back();
                                            controller
                                                .changeLanguage(lang);
                                            Get.snackbar(
                                              'اللغة',
                                              'تم تغيير اللغة إلى ${lang.toUpperCase()}',
                                            );
                                          },
                                        ),
                                        barrierDismissible: false,
                                      );
                                    }
                                  },
                                  backgroundColor:
                                  Theme.of(context).backgroundColor,
                                  checkmarkColor: controller
                                      .selectedLanguage.value ==
                                      lang
                                      ? Theme.of(context)
                                      .colorScheme
                                      .surface
                                      : Theme.of(context).primaryColor,
                                  side: BorderSide.none,
                                  selectedColor:
                                  Theme.of(context).primaryColor,
                                  labelStyle: TextStyle(
                                    color: controller
                                        .selectedLanguage.value ==
                                        lang
                                        ? Theme.of(context)
                                        .colorScheme
                                        .surface
                                        : Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
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
