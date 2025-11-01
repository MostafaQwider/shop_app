import 'package:flutter/material.dart';

abstract class AppColor {
  // الألوان الأساسية
  static const Color orange = Color(0xffF67952);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);

  // ألوان الوضع المظلم
  static const Color blackBg = Color(0xFF1E1E1E); // خلفية بطاقة/AppBar
  static const Color white54 = Colors.white54; // نصوص خافتة في الوضع المظلم
  static const Color darkGrey = Color.fromRGBO(64, 64, 64, 1);
  static const Color lightGrey = Color.fromRGBO(176, 176, 176, 1);
  static const Color grey = Color.fromRGBO(97, 97, 97, 1);
  static const Color darkWhite = Color.fromRGBO(246, 246, 246, 1);
  // ألوان مساعدة
  static const Color gray = Color(0xFF767680);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF$hexColor";
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
