import '../../domain/entities/products_entity.dart';
import '../../domain/repositories/product_local_repository.dart';
import '../data_sources/product_local_datasource.dart';
import '../models/api_response.dart';

class ProductLocalRepositoryImpl implements ProductLocalRepository {
  final ProductLocalDateSource remoteDateSource;

  ProductLocalRepositoryImpl(this.remoteDateSource);


  @override
  Future<ApiResponse<List<ProductEntity>>> products() async {
    final responseModel = await remoteDateSource.products();

    if (responseModel.data != null) {
      return ApiResponse<List<ProductEntity>>(
        status: responseModel.status,
        data: responseModel.data!.map((e) => e.toEntity()).toList(),
        message: responseModel.message,
      );
    } else {
      return ApiResponse<List<ProductEntity>>(
        status: responseModel.status,
        message: responseModel.message,
      );
    }
  }
}
