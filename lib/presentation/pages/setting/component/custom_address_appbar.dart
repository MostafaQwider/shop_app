import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/strings.dart';
import '../../../routes/app_routes.dart';


class CustomAddressAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAddressAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title:  Text(
       AppStrings.deliveryAddress.tr,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios),
      ),
      actions: [
        Center(
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.optionAddressRoute,arguments: {
                "type":"add"
              });
            },
            child:  Text(
              AppStrings.add.tr,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
