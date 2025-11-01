import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/detail/detail_controller.dart';

class DetailScreenSelectSize extends StatelessWidget {
  final DetailController controller;

  const DetailScreenSelectSize({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.sizes.length,
        itemBuilder: (ctx, i) {
          final size = controller.sizes[i];

          return Obx(() {
            final isSelected = controller.selectedSize.value == size.id;

            return GestureDetector(
              onTap: () => controller.setSize(size.id),
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected
                      ? theme.primaryColor
                      : theme.cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.3),
                      blurRadius: 5,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  size.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: isSelected
                        ? Colors.white
                        : theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
