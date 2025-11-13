import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingo/core/constants/strings.dart';

import '../../../../domain/entities/address_entity.dart';
import '../../../controllers/setting/address_controller.dart';
import '../../../routes/app_routes.dart';

class AddressListview extends StatelessWidget {
  const AddressListview({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AddressController>(
      builder:(controller) =>  ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.addresses.length,
        itemBuilder: (context, index) {
          final item = controller.addresses[index];
          return InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.optionAddressRoute,
              arguments: {"type": "update", "address": item});
            },
            // onLongPress: () {
            //   controller.removeAddress(item);
            // },
            child: Card(
              margin: const EdgeInsets.all(10),
              surfaceTintColor: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان الكارد مع أيقونة التعديل
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.addressType,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.edit, color: Theme.of(context).primaryColor),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "${AppStrings.city.tr}: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).hintColor),
                        ),
                        Expanded(
                          child: Text(
                            item.city,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Theme.of(context).hintColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    // الشارع
                    Row(
                      children: [
                        Text(
                          "${AppStrings.street.tr}: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).hintColor),
                        ),
                        Expanded(
                          child: Text(
                            item.streetName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Theme.of(context).hintColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    item.companyName!=null?
                    Row(
                      children: [
                        Text(
                          "${AppStrings.companyName.tr}: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).hintColor),
                        ),
                        Expanded(
                          child: Text(
                            item.companyName ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ),
                      ],
                    ):const SizedBox(),
                    item.companyName!=null?const SizedBox(height: 5):const SizedBox(),
                    // رقم البناء / البيت / الشركة
                    Row(
                      children: [
                        Text(
                          item.addressType==AppStrings.apartment.tr?
                          "${AppStrings.buildingNum.tr}: ":
                          item.addressType==AppStrings.house.tr?
                          "${AppStrings.houseNum.tr}: ":
                          "${AppStrings.companyNum.tr}: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).hintColor),
                        ),
                        Expanded(
                          child: Text(
                            '${item.buildingNumber ?? item.houseNumber ?? item.companyNumber}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // الطابق
                    item.floor!=null?
                    Row(
                      children: [
                        Text(
                          "${AppStrings.floor.tr}: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).hintColor),
                        ),
                        Expanded(
                          child: Text(
                            '${item.floor ?? ""}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ),
                      ],
                    ):const SizedBox(),
                    item.floor!=null?const SizedBox(height: 5):const SizedBox(),

                    // رقم الهاتف
                    Row(
                      children: [
                        Text(
                          "${AppStrings.phoneNumber.tr}: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).hintColor),
                        ),
                        Expanded(
                          child: Text(
                            item.phoneNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
