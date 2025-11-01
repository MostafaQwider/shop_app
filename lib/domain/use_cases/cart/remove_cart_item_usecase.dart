
import '../../entities/cart_item_entity.dart';
import '../../repositories/cart_repository.dart';

class RemoveCartItemUseCase {
  final CartRepository repository;

  RemoveCartItemUseCase(this.repository);

  Future<void> call(CartItemEntity item) async {
    await repository.removeFromCart(item);
  }
}
