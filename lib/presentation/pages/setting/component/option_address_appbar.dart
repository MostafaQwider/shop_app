import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/strings.dart';


class OptionAddressAppbar extends StatelessWidget implements PreferredSizeWidget {
  const OptionAddressAppbar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {

    return AppBar(
      title:  Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios),
      ),

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
