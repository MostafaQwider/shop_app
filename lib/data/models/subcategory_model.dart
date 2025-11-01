import '../../domain/entities/subcategory_entity.dart';

class SubcategoryModel {
  final SubcategoryEntity entity;

  SubcategoryModel({required this.entity});

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      entity: SubcategoryEntity(
        id: json['id'],
        name: json['name'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'name': entity.name,
    };
  }

  SubcategoryEntity toEntity() => entity;

  factory SubcategoryModel.fromEntity(SubcategoryEntity entity) {
    return SubcategoryModel(entity: entity);
  }
}
