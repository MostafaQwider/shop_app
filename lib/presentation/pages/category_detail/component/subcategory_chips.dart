import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingo/presentation/controllers/category_detail/category_detail_controller.dart';

class SubCategoryChips extends StatelessWidget {
  SubCategoryChips({
    super.key,
  });

  final CategoryDetailController controller = Get.find();

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
        itemCount: controller.subcategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = controller.selectedSubcategoryId == controller.subcategories[index].id;
          return ChoiceChip(
            label: Text(controller.subcategories[index].name),
            selected: isSelected,
            onSelected: (_) => controller.selectSubcategory(controller.subcategories[index].id),
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
