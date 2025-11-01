import '../../domain/entities/categories_entity.dart';

class CategoriesModel {
  final CategoriesEntity entity;

  CategoriesModel({required this.entity});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      entity: CategoriesEntity(
        id: json['id'],
        parent: json['parent'] != null
            ? CategoriesModel.fromJson(json['parent']).toEntity()
            : null,
        name: json['name'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'parent': entity.parent,
      'name': entity.name,
    };
  }

  factory CategoriesModel.fromEntity(CategoriesEntity entity) {
    return CategoriesModel(entity: entity);
  }

  CategoriesEntity toEntity() {
    return entity;
  }
}
