import '../../../data/models/api_response.dart';
import '../../entities/users_entity.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<Either<String, ApiResponse<UsersEntity>>> call({
    required UsersEntity user,
  }) async {
    try {
      final response = await repository.register(user);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
