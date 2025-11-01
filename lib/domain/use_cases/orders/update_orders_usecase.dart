
import 'package:dartz/dartz.dart';

import '../../../data/models/api_response.dart';
import '../../entities/orders_entity.dart';
import '../../repositories/order_repository.dart';

class UpdateOrderUseCase {
  final OrderRepository repository;

  UpdateOrderUseCase(this.repository);
  Future<Either<String, ApiResponse>> call(OrdersEntity item) async {
    try {
      return Right(await repository.updateOrder(item));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
