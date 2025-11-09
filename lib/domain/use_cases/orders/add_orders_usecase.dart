import 'package:dartz/dartz.dart';

import '../../../data/models/api_response.dart';
import '../../entities/orders_entity.dart';
import '../../repositories/order_repository.dart';

class AddOrderUseCase {
  final OrderRepository repository;

  AddOrderUseCase(this.repository);

  Future<Either<String, ApiResponse<int>>> call(
      OrdersEntity item) async {
    try {
      return Right(await repository.addOrder(item));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
