import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingo/presentation/component/app_button.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../controllers/checkout/checkout_controller.dart';
import '../../../routes/app_routes.dart';

class DeliveryAddressSection extends StatelessWidget {
  final CheckoutController controller;

  const DeliveryAddressSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppStrings.deliveryAddress.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 10),
        if (controller.address.isEmpty)
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppStrings.notFoundAddress.tr),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AppButton(
                  text: AppStrings.add.tr,
                  onPressed: () => Get.toNamed(AppRoutes.optionAddressRoute,
                      arguments: {"type": "add"}),
                ),
              )
            ],
          )
        else
          SizedBox(
            height: 180,
            child: ListView.builder(
              itemCount: controller.address.length,
              itemBuilder: (context, index) {
                final address = controller.address[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    surfaceTintColor: Theme.of(context).cardColor,
                    child: ListTile(
                      leading: Checkbox.adaptive(
                        value: controller.isSelectedAddress(address.id!),
                        activeColor: AppColor.orange,
                        onChanged: (_) => controller.setAddress(address.id!),
                      ),
                      title: Text(
                        address.addressType,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${address.streetName}, ${address.city}, ${address.country}',
                        style:
                            const TextStyle(fontSize: 12, color: AppColor.gray),
                      ),
                      trailing: GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.optionAddressRoute,
                                  arguments: {
                                    "type": "update",
                                    "address": address
                                  }),
                          child:
                              const Icon(Icons.edit, color: AppColor.orange)),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
