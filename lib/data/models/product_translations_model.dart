
import '../../domain/entities/product_translations_entity.dart';

class ProductTranslationsModel {
  final ProductTranslationsEntity entity;

  ProductTranslationsModel({required this.entity});

  factory ProductTranslationsModel.fromJson(Map<String, dynamic> json) {
    return ProductTranslationsModel(
      entity: ProductTranslationsEntity(
        id: json['id'],
        product_id: json['product_id'],
        language_code: json['language_code'],
        name: json['name'],
        description: json['description'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'product_id': entity.product_id,
      'language_code': entity.language_code,
      'name': entity.name,
      'description': entity.description,
    };
  }

  factory ProductTranslationsModel.fromEntity(ProductTranslationsEntity entity) {
    return ProductTranslationsModel(entity: entity);
  }

  ProductTranslationsEntity toEntity() {
    return entity;
  }
}
