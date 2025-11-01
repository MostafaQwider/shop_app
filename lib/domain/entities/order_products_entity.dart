
import 'orders_entity.dart';
import 'categories_entity.dart';
import 'product_images_entity.dart';
import 'product_variants_entity.dart';
class OrderProductsEntity {
  List<ProductWithQuantityEntity> product;
  OrdersEntity order;

  OrderProductsEntity(
    this.product,
    this.order,
  );
}


class ProductWithQuantityEntity {
  final int id;
  final int quantity;
  final double basePrice;
  final DateTime createdAt;
  final String productName;
  final String productDescription;
  final CategoriesEntity category;
  final List<ProductImagesEntity> images;
  final List<ProductVariantsEntity> variants;

  ProductWithQuantityEntity({
    required this.id,
    required this.quantity,
    required this.basePrice,
    required this.createdAt,
    required this.productName,
    required this.productDescription,
    required this.category,
    required this.images,
    required this.variants,
  });
}

