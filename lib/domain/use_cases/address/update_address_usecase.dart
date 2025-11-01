
import 'package:dartz/dartz.dart';

import '../../../data/models/api_response.dart';
import '../../entities/address_entity.dart';
import '../../repositories/address_repository.dart';

class UpdateAddressUseCase {
  final AddressRepository repository;

  UpdateAddressUseCase(this.repository);
  Future<Either<String, ApiResponse>> call(AddressEntity item) async {
    try {
      return Right(await repository.updateAddress(item));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
