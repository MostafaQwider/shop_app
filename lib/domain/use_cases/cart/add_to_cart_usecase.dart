
import '../../entities/cart_item_entity.dart';
import '../../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> call(CartItemEntity item) async {
    await repository.addToCart(item);
  }
}
