import 'package:flutter/material.dart';
import 'package:shopingo/presentation/controllers/category_detail/category_detail_controller.dart';
import '../../../../domain/entities/all_category_entity.dart';

class CategoryChips extends StatelessWidget {
  final List<AllCategoryEntity> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

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
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return ChoiceChip(
            label: Text(categories[index].name),
            selected: isSelected,
            onSelected: (_) => onCategorySelected(categories[index].categoryId),
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
