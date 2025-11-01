import '../../domain/entities/order_items_entity.dart';

class OrderItemsModel {
  final OrderItemsEntity entity;

  OrderItemsModel({required this.entity});

  factory OrderItemsModel.fromJson(Map<String, dynamic> json) {
    return OrderItemsModel(
      entity: OrderItemsEntity(
        id: json['id'],
        product_id: json['product_id'],
        color_id: json['color_id'],
        size_id: json['size_id'],
        quantity: json['quantity'],
        price: (json['price'] as num).toDouble(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'size_id': entity.size_id,
      'product_id': entity.product_id,
      'color_id': entity.color_id,
      'quantity': entity.quantity,
      'price': entity.price,
    };
  }

  factory OrderItemsModel.fromEntity(OrderItemsEntity entity) {
    return OrderItemsModel(entity: entity);
  }

  OrderItemsEntity toEntity() {
    return entity;
  }
}
