import 'package:shopingo/domain/entities/cart_item_entity.dart';

class CartItemModel {
  final CartItemEntity entity;

  const CartItemModel({required this.entity});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      entity: CartItemEntity(
        productId: json['productId'],
        colorId: json['colorId'],
        sizeId: json['sizeId'],
        quantity: json['quantity'] ?? 1,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': entity.productId,
      'colorId': entity.colorId,
      'sizeId': entity.sizeId,
      'quantity': entity.quantity,
    };
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(entity: entity);
  }

  CartItemEntity toEntity() => entity;
}
