import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<void> addToCart(CartItemEntity item);
  Future<List<CartItemEntity>> getCart();
  Future<void> removeFromCart(CartItemEntity item);
  Future<void> minesQuantityFromCart(CartItemEntity item);
  Future<void> clearCart();
}
