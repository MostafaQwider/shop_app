
import '../../domain/entities/product_variants_entity.dart';
import 'colors_model.dart';
import 'sizes_model.dart';

class ProductVariantsModel {
  final ProductVariantsEntity entity;

  ProductVariantsModel({required this.entity});

  factory ProductVariantsModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantsModel(
      entity: ProductVariantsEntity(
        id: json['id'],
        color: ColorsModel.fromJson(json['color']).toEntity(),
        size: SizesModel.fromJson(json['size']).toEntity(),
        stock: json['stock'],
        price: (json['price'] as num).toDouble(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'color_id': entity.color,
      'size_id': entity.size,
      'stock': entity.stock,
      'price': entity.price,
    };
  }

  factory ProductVariantsModel.fromEntity(ProductVariantsEntity entity) {
    return ProductVariantsModel(entity: entity);
  }

  ProductVariantsEntity toEntity() {
    return entity;
  }
}
