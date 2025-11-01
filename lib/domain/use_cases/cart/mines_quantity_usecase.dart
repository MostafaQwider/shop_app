
import '../../entities/cart_item_entity.dart';
import '../../repositories/cart_repository.dart';

class MinesQuantityCartUseCase {
  final CartRepository repository;

  MinesQuantityCartUseCase(this.repository);

  Future<void> call(CartItemEntity item) async {
    await repository.minesQuantityFromCart(item);
  }
}
