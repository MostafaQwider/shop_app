import '../../../data/models/api_response.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  Future<Either<String, ApiResponse>> call() async {
    try {
      final response = await repository.logout();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
