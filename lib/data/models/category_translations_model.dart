import '../../domain/entities/category_translations_entity.dart';


class CategoryTranslationsModel {
  final CategoryTranslationsEntity entity;

  CategoryTranslationsModel({required this.entity});

  factory CategoryTranslationsModel.fromJson(Map<String, dynamic> json) {
    return CategoryTranslationsModel(
      entity: CategoryTranslationsEntity(
        id: json['id'],
        category_id: json['category_id'],
        language_code: json['language_code'],
        name: json['name'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'category_id': entity.category_id,
      'language_code': entity.language_code,
      'name': entity.name,
    };
  }

  factory CategoryTranslationsModel.fromEntity(CategoryTranslationsEntity entity) {
    return CategoryTranslationsModel(entity: entity);
  }

  CategoryTranslationsEntity toEntity() {
    return entity;
  }
}
