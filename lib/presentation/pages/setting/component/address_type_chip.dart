import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingo/presentation/controllers/setting/option_address_controller.dart';

import '../../../../../core/constants/colors.dart';

class AddressTypeChip extends StatelessWidget {
  const AddressTypeChip({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OptionAddressController>(
      builder:(controller) =>  SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(controller.types.length, (index) {
            return GestureDetector(
              onTap: () {
                controller.onAddressTypeChange(index);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
                width: Get.width * 0.287,
                decoration: BoxDecoration(
                  color: controller.addressType == index
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color:Theme.of(context).primaryColor
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                     controller.typesIcons[index],
                      color: controller.addressType == index
                          ? AppColor.white
                          : Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: Text(
                        controller.types[index],
                        softWrap: false,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: controller.addressType == index
                              ? AppColor.white
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
