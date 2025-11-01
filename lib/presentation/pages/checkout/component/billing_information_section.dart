import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../controllers/checkout/checkout_controller.dart';
import 'package:get/get.dart';

class BillingInformationSection extends StatelessWidget {
  final CheckoutController controller;

  const BillingInformationSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.billingInformation.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Card(
            surfaceTintColor: Theme.of(context).cardColor,

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _priceRow(AppStrings.deliveryFee.tr, controller.deliveryFee),
                  _priceRow(AppStrings.tax.tr, controller.fax),
                  _priceRow(AppStrings.subtotal.tr, controller.subTotal),
                  const Divider(),
                  _priceRow(AppStrings.total.tr, controller.getPriceTotal(),
                      isTotal: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _priceRow(String title, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal ? AppColor.black : AppColor.gray,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
