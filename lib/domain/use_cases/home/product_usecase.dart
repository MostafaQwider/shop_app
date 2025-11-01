import 'package:dartz/dartz.dart';
import '../../../data/models/api_response.dart';
import '../../entities/products_entity.dart';
import '../../repositories/home_repository.dart';

class ProductUseCase {
  final HomeRepository repository;

  ProductUseCase(this.repository);

  Future<Either<String, ApiResponse<List<ProductEntity>>>> call() async {
    try {
      final products = await repository.products();
      return Right(products);
    } catch (e) {
      return Left(e.toString()); // أو أي Failure مخصص لديك
    }
  }
}
