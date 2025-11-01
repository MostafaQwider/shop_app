
import 'package:dartz/dartz.dart';

import '../../../data/models/api_response.dart';
import '../../entities/address_entity.dart';
import '../../repositories/address_repository.dart';

class RemoveAddressUseCase {
  final AddressRepository repository;

  RemoveAddressUseCase(this.repository);

  Future<Either<String, ApiResponse>> call(AddressEntity item) async {
    try {
      return Right(await repository.removeAddress(item));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
