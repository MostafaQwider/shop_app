import '../../../data/models/api_response.dart';
import '../../entities/users_entity.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository repository;
  UpdateProfileUseCase(this.repository);

  Future<Either<String, ApiResponse<UsersEntity>>> call({required UsersEntity updatedUser}) async {
    try {
      final response = await repository.updateProfile(updatedUser);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
