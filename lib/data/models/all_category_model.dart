import '../../domain/entities/all_category_entity.dart';
import 'subcategory_model.dart';

class AllCategoryModel {
  final AllCategoryEntity entity;

  AllCategoryModel({required this.entity});

  factory AllCategoryModel.fromJson(Map<String, dynamic> json) {
    return AllCategoryModel(
      entity: AllCategoryEntity(
        categoryId: json['category_id'],
        name: json['name'],
        subcategories: (json['subcategories'] as List<dynamic>)
            .map((e) => SubcategoryModel.fromJson(e).toEntity())
            .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': entity.categoryId,
      'name': entity.name,
      'subcategories':
      entity.subcategories.map((e) => SubcategoryModel.fromEntity(e).toJson()).toList(),
    };
  }

  AllCategoryEntity toEntity() => entity;

  factory AllCategoryModel.fromEntity(AllCategoryEntity entity) {
    return AllCategoryModel(entity: entity);
  }
}
