import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/services/storage_service.dart';
import 'core/styles/app_theme.dart';
import 'core/translations/my_translations.dart';
import 'presentation/bindings/app_binding.dart';
import 'presentation/routes/app_pages.dart';
import 'presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  await MyTranslations.loadTranslations();

  // قراءة اللغة من التخزين
  final storedLang = await StorageService().read(key: "lang");
  Locale initialLocale;
  if (storedLang != null && storedLang.isNotEmpty) {
    initialLocale = Locale(storedLang); // مثلا 'en' أو 'ar'
  } else {
    initialLocale = Get.deviceLocale ?? const Locale('en');
  }

  runApp(ShopingoApp(initialLocale: initialLocale));
}

class ShopingoApp extends StatelessWidget {
  final Locale initialLocale;
  const ShopingoApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopingo',
      translations: MyTranslations(),
      locale: initialLocale,
      fallbackLocale: const Locale('en'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.splashRoute,
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
    );
  }
}

