import 'package:dartz/dartz.dart';
import '../../../data/models/api_response.dart';
import '../../entities/orders_entity.dart';
import '../../repositories/order_repository.dart';

class GetOrderUseCase {
  final OrderRepository repository;

  GetOrderUseCase(this.repository);

  Future<Either<String, ApiResponse<List<OrdersEntity>>>> call() async {
    try {
      return Right(await repository.getOrders());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
