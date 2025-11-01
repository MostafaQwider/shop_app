import 'package:dartz/dartz.dart';
import '../../../data/models/api_response.dart';
import '../../entities/orders_entity.dart';
import '../../repositories/order_repository.dart';

class RemoveOrderUseCase {
  final OrderRepository repository;

  RemoveOrderUseCase(this.repository);

  Future<Either<String, ApiResponse>> call(OrdersEntity item) async {
    try {
      return Right(await repository.removeOrder(item));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
