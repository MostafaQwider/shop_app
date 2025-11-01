import '../../../data/models/api_response.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';

class ChangePasswordUseCase {
  final AuthRepository repository;
  ChangePasswordUseCase(this.repository);

  Future<Either<String, ApiResponse>> call({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await repository.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
