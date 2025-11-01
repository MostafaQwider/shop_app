import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class AppTheme {
  /// Light Theme
  static ThemeData get lightTheme => ThemeData(
    fontFamily: _getFontFamily(Get.locale ?? Get.deviceLocale ?? const Locale('en')),
    scaffoldBackgroundColor: AppColor.white,
    primaryColor: AppColor.orange,
    primaryColorLight: AppColor.orange.withOpacity(0.5),
    cardColor: AppColor.white54,
    appBarTheme: appbarThemeLight,
    backgroundColor: AppColor.darkWhite,
    sliderTheme: sliderTheme,
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(color: AppColor.orange),
    ),
    iconTheme: const IconThemeData(color: AppColor.orange),
    textTheme: _getTextTheme(Get.locale ?? Get.deviceLocale ?? const Locale('en'))
        .apply(bodyColor: AppColor.orange, displayColor: AppColor.orange),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: Colors.grey),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.orange),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.orange,
        foregroundColor: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );

  /// Dark Theme
  static ThemeData get darkTheme => ThemeData(
    fontFamily: _getFontFamily(Get.locale ?? Get.deviceLocale ?? const Locale('en')),
    scaffoldBackgroundColor: AppColor.darkGrey,
    primaryColor: AppColor.orange,
    primaryColorLight: AppColor.orange.withOpacity(0.5),
    cardColor: AppColor.blackBg,
    appBarTheme: appbarThemeDark,
    sliderTheme: sliderTheme,
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(color: AppColor.orange),
    ),
    iconTheme: const IconThemeData(color: AppColor.orange),
    textTheme: _getTextTheme(Get.locale ?? Get.deviceLocale ?? const Locale('en'))
        .apply(bodyColor: AppColor.white, displayColor: AppColor.white),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: AppColor.white54),
      labelStyle: TextStyle(color: AppColor.white54),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.orange),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.white54),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.orange,
        foregroundColor: AppColor.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );

  /// AppBar Themes
  static const appbarThemeLight = AppBarTheme(
    elevation: 0.0,
    backgroundColor: AppColor.white,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: IconThemeData(color: AppColor.orange),
    titleTextStyle: TextStyle(color: AppColor.orange),
  );

  static const appbarThemeDark = AppBarTheme(
    elevation: 0.0,
    backgroundColor: AppColor.blackBg,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: AppColor.orange),
    titleTextStyle: TextStyle(color: AppColor.orange),
  );

  /// Slider Theme
  static const sliderTheme = SliderThemeData(
    showValueIndicator: ShowValueIndicator.always,
    rangeValueIndicatorShape: RectangularRangeSliderValueIndicatorShape(),
    valueIndicatorColor: AppColor.orange,
    valueIndicatorTextStyle: TextStyle(color: AppColor.white),
  );

  /// Font family حسب اللغة
  static String _getFontFamily(Locale locale) {
    switch (locale.languageCode) {
      case 'ar':
        return 'Cairo';
      case 'en':
      default:
        return 'PlayfairDisplay';
    }
  }

  /// TextTheme
  static TextTheme _getTextTheme(Locale locale) {
    final font = _getFontFamily(locale);
    return TextTheme(
      displayLarge: TextStyle(fontFamily: font, fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontFamily: font, fontSize: 28, fontWeight: FontWeight.w600),
      displaySmall: TextStyle(fontFamily: font, fontSize: 24, fontWeight: FontWeight.w500),
      titleLarge: TextStyle(fontFamily: font, fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontFamily: font, fontSize: 18, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontFamily: font, fontSize: 16, fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(fontFamily: font, fontSize: 16),
      bodyMedium: TextStyle(fontFamily: font, fontSize: 14),
      bodySmall: TextStyle(fontFamily: font, fontSize: 12),
    );
  }
}
