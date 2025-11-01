import '../../../data/models/api_response.dart';
import '../../entities/auth_response.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';

class VerifyAccountUseCase {
  final AuthRepository repository;
  VerifyAccountUseCase(this.repository);

  Future<Either<String, ApiResponse<AuthResponse>>> call({
    required String email,
    required String code,
  }) async {
    try {
      final response = await repository.verifyAccount(email: email, code: code);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
