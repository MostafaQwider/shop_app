import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repository.dart';
import '../data_sources/address_remote_datasource.dart';
import '../models/address_model.dart';
import '../models/api_response.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResponse<AddressEntity>> addAddress(AddressEntity item) async {
    final model = AddressModel.fromEntity(item);
    final responseModel = await remoteDataSource.addAddress(model);

    return ApiResponse<AddressEntity>(
      status: responseModel.status,
      message: responseModel.message,
      data: responseModel.data?.toEntity(),
    );
  }

  @override
  Future<ApiResponse<List<AddressEntity>>> getAddresses() async {
    final responseModel = await remoteDataSource.getAddresses();

    return ApiResponse<List<AddressEntity>>(
      status: responseModel.status,
      message: responseModel.message,
      data: responseModel.data?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  Future<ApiResponse> removeAddress(AddressEntity item) async {
    final responseModel =
        await remoteDataSource.removeAddress(AddressModel.fromEntity(item));

    return ApiResponse(
      status: responseModel.status,
      message: responseModel.message,
    );
  }

  @override
  Future<ApiResponse> updateAddress(AddressEntity item) async {
    final model = AddressModel.fromEntity(item);
    final responseModel = await remoteDataSource.updateAddress(model);

    return ApiResponse<AddressEntity>(
      status: responseModel.status,
      message: responseModel.message,
    );
  }
}
