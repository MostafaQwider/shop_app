import '../../domain/entities/products_entity.dart';
import 'categories_model.dart';
import 'product_images_model.dart';
import 'product_variants_model.dart';

class ProductModel {
  final ProductEntity entity;

  ProductModel({required this.entity});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      entity: ProductEntity(
        id: json['id'],
        basePrice: double.parse(json['base_price']),
        createdAt: DateTime.parse(json['created_at']),
        productName: json['product_name'],
        productDescription: json['product_description'],
        category: CategoriesModel.fromJson(json['category']).toEntity(),
        images: (json['images'] as List<dynamic>)
            .map((e) => ProductImagesModel.fromJson(e).toEntity())
            .toList(),
        variants: (json['variants'] as List<dynamic>)
            .map((e) => ProductVariantsModel.fromJson(e).toEntity())
            .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'base_price': entity.basePrice,
      'created_at': entity.createdAt.toIso8601String(),
      'product_name': entity.productName,
      'product_description': entity.productDescription,
      'category': CategoriesModel(entity: entity.category).toJson(),
      'images': entity.images
          .map((e) => ProductImagesModel(entity: e).toJson())
          .toList(),
      'variants': entity.variants
          .map((e) => ProductVariantsModel(entity: e).toJson())
          .toList(),
    };
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(entity: entity);
  }

  ProductEntity toEntity() {
    return entity;
  }
}
