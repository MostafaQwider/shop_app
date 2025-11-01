import 'package:shopingo/domain/entities/order_items_entity.dart';

class OrdersEntity {
  final int? id;
  final int address_id;
  final String? status;
  final double total;
  final String? payment_method;
  final String? payment_transaction_id;
  final String? expected_delivery_time;
  List<OrderItemsEntity> items;
  final String? created_at;

  OrdersEntity({
    this.id,
    required this.address_id,
    this.status,
    required this.total,
    required this.items,
    this.payment_method,
    this.payment_transaction_id,
    this.expected_delivery_time,
    this.created_at,
  });
}
