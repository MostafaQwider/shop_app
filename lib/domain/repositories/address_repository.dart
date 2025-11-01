

import '../../data/models/api_response.dart';
import '../entities/address_entity.dart';

abstract class AddressRepository{
  Future<ApiResponse<AddressEntity>> addAddress(AddressEntity item);
  Future<ApiResponse> updateAddress(AddressEntity item);
  Future<ApiResponse> removeAddress(AddressEntity item);
  Future<ApiResponse<List<AddressEntity>>> getAddresses();
}