import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingo/core/constants/strings.dart';

import '../../component/app_button.dart';
import '../../component/handling_data.dart';
import '../../controllers/main_screen_pages/order/order_detail_controller.dart';
import 'component/address_of_order_card.dart';
import 'component/order_item_list.dart';
class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppStrings.orderDetail.tr),
        centerTitle: true,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GetBuilder<OrderDetailController>(
            builder: (controller) => HandlingData(
                statusRequest: controller.statusRequest,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Text(
                      controller.orderStatusDescription,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          ),
                    ),
                    const SizedBox(height: 20),
                    AddressOfOrderCard(address: controller.addressEntity),
                    const SizedBox(height: 20),
                    OrderItemList(
                        items: controller.orderProductsEntity.product),
                  ],
                )),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: Get.height / 5,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            children: [
              GetBuilder<OrderDetailController>(
                builder: (controller) => Text(
                  "${controller.orderProductsEntity.order.total.toStringAsFixed(2)} \$",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              AppButton(
                text: AppStrings.or.tr,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
