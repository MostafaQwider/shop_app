import '../../../data/models/api_response.dart';
import '../../entities/users_entity.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';

class ProfileUseCase {
  final AuthRepository repository;
  ProfileUseCase(this.repository);

  Future<Either<String, ApiResponse<UsersEntity>>> call() async {
    try {
      final response = await repository.profile();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
