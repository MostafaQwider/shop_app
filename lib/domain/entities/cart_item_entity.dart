class CartItemEntity {
  final int productId;
  final int colorId;
  final int sizeId;
  final int quantity;

  const CartItemEntity({
    required this.productId,
    required this.colorId,
    required this.sizeId,
    required this.quantity,
  });
  CartItemEntity copyWith({
    int? productId,
    int? colorId,
    int? sizeId,
    int? quantity,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      colorId: colorId ?? this.colorId,
      sizeId: sizeId ?? this.sizeId,
      quantity: quantity ?? this.quantity,
    );
  }
}
