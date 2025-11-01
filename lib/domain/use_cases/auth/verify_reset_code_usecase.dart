import '../../../data/models/api_response.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';

class VerifyResetCodeUseCase {
  final AuthRepository repository;
  VerifyResetCodeUseCase(this.repository);

  Future<Either<String, ApiResponse>> call({
    required String email,
    required String code,
  }) async {
    try {
      final response = await repository.verifyResetCode(email: email, code: code);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
