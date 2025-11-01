import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_sources/cart_local_data_source.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl(this.localDataSource);

  @override
  Future<void> addToCart(CartItemEntity item) async {
    final model = CartItemModel.fromEntity(item);
    await localDataSource.addCartItem(model);
  }


  @override
  Future<List<CartItemEntity>> getCart() async {
    final models = await localDataSource.getCartItems();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> removeFromCart(CartItemEntity item) async {
    await localDataSource.removeCartItem(CartItemModel.fromEntity(item));
  }

  @override
  Future<void> clearCart() async {
    await localDataSource.clearCart();
  }

  @override
  Future<void> minesQuantityFromCart(CartItemEntity item)async {
    final model = CartItemModel.fromEntity(item);
    await localDataSource.minesQuantityFromCart(model);
  }
}
