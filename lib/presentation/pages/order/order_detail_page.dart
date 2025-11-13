import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/strings.dart';
import '../../component/app_button.dart';
import '../../component/handling_data.dart';
import '../../controllers/main_screen_pages/order/order_detail_controller.dart';
import 'component/address_of_order_card.dart';
import 'component/order_item_list.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      builder: (controller) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(AppStrings.orderDetail.tr),
          centerTitle: true,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: HandlingData(
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
        bottomNavigationBar: Container(
          height: controller.orderStatus=="pending"?Get.height / 6:Get.height / 10,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.total.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "${controller.orderProductsEntity.order.total.toStringAsFixed(2)}\$",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Visibility(
                visible: controller.orderStatus=="pending",
                child: AppButton(
                  text: AppStrings.checkout.tr,
                  onPressed: () {
                    if(controller.orderStatus=="pending")
                      controller.pay();
                  },
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
