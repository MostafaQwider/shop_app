import 'categories_entity.dart';
import 'product_images_entity.dart';
import 'product_variants_entity.dart';

class ProductEntity {
  final int id;
  final double basePrice;
  final DateTime createdAt;
  final String productName;
  final String productDescription;
  final CategoriesEntity category;
  final List<ProductImagesEntity> images;
  final List<ProductVariantsEntity> variants;

  ProductEntity({
    required this.id,
    required this.basePrice,
    required this.createdAt,
    required this.productName,
    required this.productDescription,
    required this.category,
    required this.images,
    required this.variants,
  });
}
