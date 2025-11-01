import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/detail/detail_controller.dart';

class DetailScreenSelectColor extends StatelessWidget {
  final DetailController controller;

  const DetailScreenSelectColor({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.colors.length,
        itemBuilder: (ctx, i) {
          final colorEntity = controller.colors[i];
          final colorValue = _hexToColor(colorEntity.name);

          return Obx(() {
            final isSelected = controller.selectedColor.value == colorEntity.id;

            return GestureDetector(
              onTap: () => controller.setColor(colorEntity.id),
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorValue,
                  border: isSelected
                      ? Border.all(color: theme.primaryColor, width: 3)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.3),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex'; // إضافة قيمة ألفا للشفافية
    return Color(int.parse(hex, radix: 16));
  }
}
