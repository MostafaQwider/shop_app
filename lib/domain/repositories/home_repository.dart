import '../../data/models/api_response.dart';
import '../entities/all_category_entity.dart';
import '../entities/products_entity.dart';

abstract class HomeRepository{
  Future<ApiResponse<List<ProductEntity>>> products();
  Future<ApiResponse<List<AllCategoryEntity>>> categories();
}