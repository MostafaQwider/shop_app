import 'package:dartz/dartz.dart';

import '../../../data/models/api_response.dart';
import '../../entities/address_entity.dart';
import '../../repositories/address_repository.dart';

class AddAddressUseCase {
  final AddressRepository repository;

  AddAddressUseCase(this.repository);

  Future<Either<String, ApiResponse>> call(
      AddressEntity item) async {
    try {
      return Right(await repository.addAddress(item));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
