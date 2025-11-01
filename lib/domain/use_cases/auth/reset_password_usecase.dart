import '../../../data/models/api_response.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;
  ResetPasswordUseCase(this.repository);

  Future<Either<String, ApiResponse>> call({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await repository.resetPassword(
        email: email,
        newPassword: newPassword,
      );
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
