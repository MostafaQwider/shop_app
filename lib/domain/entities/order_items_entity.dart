class OrderItemsEntity {
  final int? id;
  final int product_id;
  final int color_id;
  final int size_id;
  final int quantity;
  final double price;

  OrderItemsEntity({
    this.id,
    required this.product_id,
    required this.color_id,
    required this.size_id,
    required this.quantity,
    required this.price,
  });
}
