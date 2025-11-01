
import 'colors_entity.dart';
import 'sizes_entity.dart';


class ProductVariantsEntity {
  final int id;
  final ColorsEntity color;
  final SizesEntity size;
  final int? stock;
  final double price;

  ProductVariantsEntity({
    required this.id,
    required this.color,
    required this.size,
    this.stock,
    required this.price,
  });
}
