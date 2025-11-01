import 'package:dartz/dartz.dart';

import '../../../data/models/api_response.dart';
import '../../entities/address_entity.dart';
import '../../repositories/address_repository.dart';

class GetAddressUseCase {
  final AddressRepository repository;

  GetAddressUseCase(this.repository);

  Future<Either<String, ApiResponse<List<AddressEntity>>>> call() async {
    try {
      return Right(await repository.getAddresses());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
