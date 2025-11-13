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
          child: GetBuilder<SettingsController>(
            builder: (controller) => HandlingData(
              onTryAgain: controller.loadData,
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
                        title: AppStrings.accountSettings.tr,
                        isExpanded: controller.isAccountSettingsExpanded.value,
                        onTap: controller.toggleAccountSettings,
                        children: [
                          BuildSubSettingItem(
                            title: AppStrings.changePassword.tr,
                            icon: AssetsManager.lock,
                            onTap: () async {
                              if (!await controller.isGuest()) {
                                Get.toNamed(AppRoutes.changePasswordRoute);
                              }
                            },
                          ),

                          // ✅ تسجيل الخروج باستخدام AppDialog
                          BuildSubSettingItem(
                            title: AppStrings.logout.tr,
                            icon: AssetsManager.logout,
                            onTap: () {
                              Get.dialog(
                                AppDialog(
                                  message:
                                     AppStrings.areYouSureToLogout.tr,
                                  cancelText: AppStrings.cancel.tr,
                                  confirmText: AppStrings.confirm.tr,
                                  onCancel: () => Get.back(),
                                  onConfirm: () {
                                    Get.back(); // إغلاق مربع الحوار
                                    controller
                                        .logout(); // استدعاء دالة تسجيل الخروج من الكنترولر

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
                        onTap: () async {
                          if (!await controller.isGuest()) {
                            Get.toNamed(AppRoutes.addressRoute);
                          }
                        }),
                  ),

                  const SizedBox(height: 10),

                  // ✅ تغيير اللغة باستخدام AppDialog
                  Obx(() => BuildExpandableTile(
                        icon: AssetsManager.language,
                        title:  AppStrings.changeLanguage.tr,
                        isExpanded: controller.isLanguageSettingsExpanded.value,
                        onTap: controller.toggleLanguageSettings,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:
                                  controller.availableLanguages.map((lang) {
                                return Obx(
                                  () => ChoiceChip(
                                    label: Text(lang.toUpperCase()),
                                    selected:
                                        controller.selectedLanguage.value ==
                                            lang,
                                    onSelected: (selected) {
                                      if (selected) {
                                        // 🟢 تأكيد تغيير اللغة قبل التنفيذ
                                        Get.dialog(
                                          AppDialog(
                                            message:
                                            AppStrings.areYouSureToChangeLanguage.tr,
                                            cancelText:  AppStrings.cancel.tr,
                                            confirmText: AppStrings.confirm.tr,
                                            onCancel: () => Get.back(),
                                            onConfirm: () {
                                              Get.back();
                                              controller.changeLanguage(lang);
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
    );
  }
}
