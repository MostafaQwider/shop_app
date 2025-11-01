
import '../../data/models/api_response.dart';
import '../entities/products_entity.dart';

abstract class ProductLocalRepository{
  Future<ApiResponse<List<ProductEntity>>> products();
}