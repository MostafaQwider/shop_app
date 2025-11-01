import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopingo/core/constants/strings.dart';

import '../../../../core/constants/assets_manager.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, this.controller});
  final controller;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 45,
        child: TextFormField(
          controller: controller.searchController,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            fillColor: Theme.of(context).backgroundColor,
            filled: true,
            contentPadding: const EdgeInsets.all(10),
            hintText: AppStrings.search.tr,
            hintStyle: TextStyle(
              color: Theme.of(context).hintColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                AssetsManager.search,
                height: 20,
                width: 20,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
