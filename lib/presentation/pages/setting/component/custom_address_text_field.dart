import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/strings.dart';

class CustomAddressTextField extends StatelessWidget {
  const CustomAddressTextField({
    super.key,
    required this.hint,
    this.controller,
    this.optional = false,
    required this.textInputType,
  });

  final String hint;
  final bool optional;
  final TextEditingController? controller;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 50, // 👈 ارتفاع ثابت وآمن
        maxHeight: 50,
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColor,
        controller: controller,
        keyboardType: textInputType,
        validator: (value) {
          if (optional) {
            return null;
          }
          if (value == null || value.isEmpty) {
            return AppStrings.pleaseFillTheField.tr;
          }
          return null;
        },
        style: TextStyle(color: Theme.of(context).primaryColor),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          hintText: hint.tr,
          hintStyle: TextStyle(color: Theme.of(context).hintColor),
          labelText: hint.tr
        ),
      ),
    );
  }
}
