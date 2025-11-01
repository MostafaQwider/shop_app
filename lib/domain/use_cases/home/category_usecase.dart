import 'package:dartz/dartz.dart';
import '../../../data/models/api_response.dart';
import '../../entities/all_category_entity.dart';
import '../../repositories/home_repository.dart';

class CategoryUseCase {
  final HomeRepository repository;

  CategoryUseCase(this.repository);

  Future<Either<String, ApiResponse<List<AllCategoryEntity>>>> call() async {
    try {
      final categories = await repository.categories();
      return Right(categories);
    } catch (e) {
      return Left(e.toString()); // أو أي Failure مخصص لديك
    }
  }
}
