
import '../../domain/entities/product_images_entity.dart';

class ProductImagesModel {
  final ProductImagesEntity entity;

  ProductImagesModel({required this.entity});

  factory ProductImagesModel.fromJson(Map<String, dynamic> json) {
    return ProductImagesModel(
      entity: ProductImagesEntity(
        id: json['id'],
        image_url: json['image_url'],
        is_main: json['is_main'] ?? false,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'image_url': entity.image_url,
      'is_main': entity.is_main,
    };
  }

  factory ProductImagesModel.fromEntity(ProductImagesEntity entity) {
    return ProductImagesModel(entity: entity);
  }

  ProductImagesEntity toEntity() {
    return entity;
  }
}
