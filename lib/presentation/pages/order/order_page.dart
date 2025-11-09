import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/handling_data.dart';
import '../../controllers/main_screen_pages/order/order_controller.dart';
import '../../routes/app_routes.dart';
import 'component/order_card.dart';
import 'component/order_status_chip.dart';
class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GetBuilder<OrderController>(
            builder: (controller) => RefreshIndicator(
              color: Theme.of(context).primaryColor,
              onRefresh: () => controller.loadData(),
              child: HandlingData(
                  onTryAgain: controller.loadData,
                  statusRequest: controller.statusRequest,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      OrderStatusChips(),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredOrder.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.orderDetailRoute,
                              arguments: {
                                "address": controller.getAddress(
                                    controller.filteredOrder[index].address_id),
                                "status": controller.orderStatusKeys[
                                    controller.orderStateSelectedIndex],
                                "orderProducts": controller.getOrderProducts(
                                    controller.filteredOrder[index].id)
                              }),
                          child: OrderCard(
                              order: controller.getOrderProducts(
                                  controller.filteredOrder[index].id)),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
