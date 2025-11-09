import '../../data/models/api_response.dart';
import '../entities/orders_entity.dart';

abstract class OrderRepository{
  Future<ApiResponse<int>> addOrder(OrdersEntity item);
  Future<ApiResponse> updateOrder(OrdersEntity item);
  Future<ApiResponse> removeOrder(OrdersEntity item);
  Future<ApiResponse<List<OrdersEntity>>> getOrders();
}