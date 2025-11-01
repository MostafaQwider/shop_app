
import '../../repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  Future<void> call() async {
    await repository.clearCart();
  }
}
