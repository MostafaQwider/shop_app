import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/strings.dart';
import '../../component/app_button.dart';
import '../../component/app_snack_bar.dart';
import '../../component/handling_data.dart';
import '../../controllers/setting/option_address_controller.dart';
import 'component/address_type_chip.dart';
import 'component/custom_address_text_field.dart';
import 'component/option_address_appbar.dart';
class OptionAddressPage extends StatelessWidget {
  const OptionAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    // استدعاء الكنترولر عبر Get.put أو Get.find (حسب كيفية الربط في المشروع)
    final controller = Get.find<OptionAddressController>();
    return Scaffold(
      appBar: OptionAddressAppbar(
          title: controller.type == "update"
              ? AppStrings.editAddress.tr
              : AppStrings.add.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.globalKey,
            child: GetBuilder<OptionAddressController>(
              builder: (ctrl) => HandlingData(
                statusRequest: ctrl.statusRequest,
                child: Column(
                  children: [
                    // نوع العنوان (شقة / بيت / مكتب)
                    const AddressTypeChip(),
                    const SizedBox(height: 20),
                    CustomAddressTextField(
                      hint: AppStrings.conutry.tr,
                      controller: controller.country,
                      textInputType: TextInputType.text,
                    ),

                    const SizedBox(height: 20),
                    CustomAddressTextField(
                      hint: AppStrings.city.tr,
                      controller: controller.city,
                      textInputType: TextInputType.text,
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomAddressTextField(
                            hint: ctrl.hint[ctrl.addressType],
                            controller: ctrl.buildingNum,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (ctrl.addressType != 1)
                          Expanded(
                            child: CustomAddressTextField(
                              hint: AppStrings.floor.tr,
                              controller: ctrl.floor,
                              textInputType: TextInputType.number,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    CustomAddressTextField(
                      hint: AppStrings.street.tr,
                      controller: controller.street,
                      textInputType: TextInputType.text,
                    ),

                    const SizedBox(height: 20),

                    CustomAddressTextField(
                      hint: AppStrings.additionalDirectionsOptional.tr,
                      optional: true,
                      controller: controller.additional,
                      textInputType: TextInputType.text,
                    ),

                    const SizedBox(height: 20),

                    CustomAddressTextField(
                      hint: AppStrings.phoneNumber.tr,
                      controller: controller.phone,
                      textInputType: TextInputType.phone,
                    ),

                    const SizedBox(height: 20),

                    if (controller.addressType == 2)
                      CustomAddressTextField(
                        hint: AppStrings.companyName.tr,
                        controller: controller.companyName,
                        textInputType: TextInputType.text,
                      ),

                    const SizedBox(height: 20),

                    AppButton(
                      text:ctrl.type == 'update'? AppStrings.save.tr:
                      AppStrings.add.tr,
                      onPressed: () {
                        if (ctrl.globalKey.currentState!.validate()) {
                          if (ctrl.type == 'update') {
                            ctrl.updateAddress();
                          } else {
                            ctrl.addAddress();
                          }
                        } else {
                          showToastMessage(
                            label: "",
                            text: AppStrings.pleaseFillTheField.tr,
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
