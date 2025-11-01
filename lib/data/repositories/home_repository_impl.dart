import '../../domain/entities/all_category_entity.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_remote_datasource.dart';
import '../models/api_response.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDateSource remoteDateSource;

  HomeRepositoryImpl(this.remoteDateSource);

  @override
  Future<ApiResponse<List<AllCategoryEntity>>> categories() async {
    final responseModel = await remoteDateSource.categories();

    if (responseModel.data != null) {
      return ApiResponse<List<AllCategoryEntity>>(
        status: responseModel.status,
        data: responseModel.data!.map((e) => e.toEntity()).toList(),
        message: responseModel.message,
      );
    } else {
      return ApiResponse<List<AllCategoryEntity>>(
        status: responseModel.status,
        message: responseModel.message,
      );
    }
  }

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
