import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../controllers/checkout/checkout_controller.dart';

class ProductInformationSection extends StatelessWidget {
  final CheckoutController controller;

  const ProductInformationSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.productsInformation.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Card(
            surfaceTintColor: Theme.of(context).cardColor,

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.productName.tr,
                          style: const TextStyle(
                              color: AppColor.gray, fontSize: 12)),
                      const Text(AppStrings.count,
                          style:
                          TextStyle(color: AppColor.gray, fontSize: 12)),
                      const Text(AppStrings.price,
                          style:
                          TextStyle(color: AppColor.gray, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...controller.products.map((p) {
                    final qty = controller.getQuantity(p);
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              p.productName.length > 22
                                  ? p.productName.substring(0, 22)
                                  : p.productName,
                              style: const TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(qty.toString(),
                              style: const TextStyle(fontSize: 14)),
                          Text('\$${p.basePrice}',
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
