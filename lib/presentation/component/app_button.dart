import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // استخدم الثيم لتوحيد الألوان والنمط

    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: theme.colorScheme.onPrimary, // نص أبيض
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary, // لضمان التباين الجيد
            fontSize: 14
          ),
        ),
      ),
    );
  }
}
