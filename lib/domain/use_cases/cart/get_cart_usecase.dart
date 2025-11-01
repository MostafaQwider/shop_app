
import '../../entities/cart_item_entity.dart';
import '../../repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Future<List<CartItemEntity>> call() async {
    return await repository.getCart();
  }
}
