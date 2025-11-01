import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/colors.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final bool isNumeric;
  final bool? obscureText;
  final VoidCallback? onIconTap;
  final bool showIcon;

  const AppTextFormField({
    super.key,
    this.obscureText,
    this.onIconTap,
    required this.hintText,
    this.labelText,
    required this.icon,
    required this.controller,
    required this.validator,
    required this.isNumeric,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // مسافة من اليمين واليسار
      child: TextFormField(
        cursorColor: AppColor.orange,
        keyboardType: isNumeric
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: validator,
        controller: controller,
        obscureText: obscureText ?? false,
        style: TextStyle(
          color: theme.brightness == Brightness.dark ? Colors.white : Colors.grey[800],
          fontSize: 16,
        ),
        decoration: InputDecoration(
          label: Container(
            width: Get.width/2,
            alignment: Alignment.center,
          child: Text(labelText ?? hintText),),
         // labelText: labelText ?? hintText, // إضافة label
          labelStyle: const TextStyle(color: AppColor.orange),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), // تباعد داخل الحقل
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.orange, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: showIcon
              ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: AppColor.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: onIconTap,
              child: Icon(
                icon,
                color: AppColor.orange,
                size: 20,
              ),
            ),
          )
              : null,
        ),
      ),
    );
  }
}
