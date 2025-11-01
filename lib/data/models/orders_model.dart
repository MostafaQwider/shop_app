import 'package:shopingo/data/models/order_items_model.dart';

import '../../domain/entities/orders_entity.dart';

class OrdersModel {
  final OrdersEntity entity;

  OrdersModel({required this.entity});

    factory OrdersModel.fromJson(Map<String, dynamic> json) {
      return OrdersModel(
        entity: OrdersEntity(
          id: json['id'],
          address_id: json['address_id'],
          status: json['status'],
          total: double.tryParse(json['total'].toString()) ?? 0.0,
          payment_method: json['payment_method'],
          expected_delivery_time: json['expected_delivery_time'],
          payment_transaction_id: json['payment_transaction_id'],
          items: (json['items'] as List<dynamic>)
              .map((e) => OrderItemsModel.fromJson(e).toEntity())
              .toList(),
          created_at: json['created_at'].toString(),
        ),
      );
    }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'status': entity.status,
      'total': entity.total,
      'address_id': entity.address_id,
      'payment_method': entity.payment_method,
      'expected_delivery_time': entity.expected_delivery_time,
      'payment_transaction_id': entity.payment_transaction_id,
      'items': entity.items.map((e) => OrderItemsModel.fromEntity(e).toJson()).toList(),
    };
  }

  factory OrdersModel.fromEntity(OrdersEntity entity) {
    return OrdersModel(entity: entity);
  }

  OrdersEntity toEntity() {
    return entity;
  }
}
