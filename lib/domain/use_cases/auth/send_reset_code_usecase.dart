import '../../../data/models/api_response.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';

class SendResetCodeUseCase {
  final AuthRepository repository;
  SendResetCodeUseCase(this.repository);

  Future<Either<String, ApiResponse>> call({required String email}) async {
    try {
      final response = await repository.sendResetCode(email);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
