
import '../../repositories/auth_repository.dart';

class IsAGuestUseCase {
  final AuthRepository repository;

  IsAGuestUseCase(this.repository);

  Future<bool> call() async {
    return await repository.isAGuest();
  }
}
