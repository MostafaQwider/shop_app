
import '../../repositories/auth_repository.dart';

class ContinueAsAGuestUseCase {
  final AuthRepository repository;

  ContinueAsAGuestUseCase(this.repository);

  Future<void> call() async {
    return await repository.continueAsAGuest();
  }
}
