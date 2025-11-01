import 'subcategory_entity.dart';

class AllCategoryEntity {
  final int categoryId;
  final String name;
  final List<SubcategoryEntity> subcategories;

  AllCategoryEntity({
    required this.categoryId,
    required this.name,
    required this.subcategories,
  });
}
