import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/colors.dart';

Future<void> showToastMessage({
  required String label,
  required String text,
}) async {
  Get.snackbar(
    '', '', // نتركهم فاضيين لأننا نستخدم titleText و messageText
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.all(8), // تقليل الهامش الخارجي
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // تصغير المسافات الداخلية
    backgroundColor: AppColor.orange.withOpacity(0.9),
    borderRadius: 10,
    snackStyle: SnackStyle.FLOATING,
    maxWidth: 300, // لتصغير العرض
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
      ),
    ],
    titleText: Text(
      label,
      style: const TextStyle(
        fontSize: 13, // حجم عنوان صغير
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      text,
      style: const TextStyle(
        fontSize: 15, // حجم نص صغير
        color: Colors.white,
      ),
    ),
  );
}
