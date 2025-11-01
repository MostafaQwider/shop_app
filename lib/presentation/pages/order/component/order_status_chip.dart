import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/main_screen_pages/order/order_controller.dart';
class OrderStatusChips extends StatelessWidget {
  OrderStatusChips({
    super.key,
  });

  final OrderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).backgroundColor;
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return SizedBox(
      height: 40, // ارتفاع ثابت مناسب للشيبس
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: controller.orderStatus.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = controller.orderStateSelectedIndex == index;
          return ChoiceChip(
            label: Text(controller.orderStatus[index]),
            selected: isSelected,
            onSelected: (_) => controller.selectStatus(index),
            backgroundColor: cardColor,
            selectedColor: primaryColor,
            checkmarkColor: Theme.of(context).colorScheme.surface,
            labelStyle: TextStyle(
              color: isSelected ? cardColor : textColor,
            ),
            side: BorderSide.none,
          );
        },
      ),
    );
  }
}
