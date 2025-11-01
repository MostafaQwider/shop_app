import '../../../data/models/api_response.dart';
import '../../entities/auth_response.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, ApiResponse<AuthResponse>>> call({
    required String email,
    required String password,
  }) async {
    try {
      final user = await repository.login( email,password);
      return Right(user);
    } catch (e) {
      return Left(e.toString()); // أو أي Failure مخصص لديك
    }
  }
}
