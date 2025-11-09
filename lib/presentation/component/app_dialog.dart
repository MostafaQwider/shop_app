import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/assets_manager.dart';
import 'app_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.message,
    required this.cancelText,
    required this.confirmText,
    this.content,
    required this.onCancel,
    required this.onConfirm,
  });

  final String message;
  final String cancelText;
  final String confirmText;
  final Widget? content;
  final void Function() onCancel;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // حجم مربع الحوار
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // مهم عشان لا ياخذ كل طول الشاشة
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: SvgPicture.asset(AssetsManager.appIcon),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (content != null) content!,
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(text: cancelText, onPressed: onCancel),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppButton(text: confirmText, onPressed: onConfirm),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
