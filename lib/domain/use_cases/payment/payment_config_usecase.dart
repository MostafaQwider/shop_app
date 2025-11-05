import 'package:dartz/dartz.dart';

import '../../../data/models/api_response.dart';
import '../../repositories/payment_config_repository.dart';
class PaymentConfigUseCase{
 PaymentConfigRepository repository;
 PaymentConfigUseCase(this.repository);
 Future<Either<String, ApiResponse>> call() async {
   try {
     return Right(await repository.getConfig());
   } catch (e) {
     return Left(e.toString());
   } }
}