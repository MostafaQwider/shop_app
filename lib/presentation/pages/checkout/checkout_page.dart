import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../component/app_button.dart';
import '../../component/handling_data.dart';
import '../../controllers/checkout/checkout_controller.dart';
import 'component/billing_information_section.dart';
import 'component/delivery_address_section.dart';
import 'component/product_information_section.dart';
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title:  Text(AppStrings.checkout.tr),
          surfaceTintColor: AppColor.white,),
          body: HandlingData(
            statusRequest:controller.statusRequest ,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(), // 🔹 مهم
              child: Column(
                children: [
                  DeliveryAddressSection(controller: controller),
                  const SizedBox(height: 20),
                  ProductInformationSection(controller: controller),
                  const SizedBox(height: 20),
                  BillingInformationSection(controller: controller),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AppButton( text: AppStrings.checkout.tr,onPressed: () => controller.addOrder(),),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }




}
