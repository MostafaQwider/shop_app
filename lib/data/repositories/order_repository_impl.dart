import '../../domain/entities/orders_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../data_sources/order_remote_datasource.dart'; // استيراد الـ datasource
import '../models/api_response.dart';
import '../models/orders_model.dart'; // استيراد الـ model

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource; // حقن الـ remoteDataSource

  OrderRepositoryImpl(this.remoteDataSource); // Constructor لاستقباله

  @override
  Future<ApiResponse> addOrder(OrdersEntity item) async {
    final model = OrdersModel.fromEntity(item);
    final responseModel = await remoteDataSource.addOrder(model);

    return ApiResponse(
      status: responseModel.status,
      message: responseModel.message,
    );
  }

  @override
  Future<ApiResponse<List<OrdersEntity>>> getOrders() async {

    final responseModel = await remoteDataSource.getOrders();

    return ApiResponse<List<OrdersEntity>>(
      status: responseModel.status,
      message: responseModel.message,
      data: responseModel.data?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  Future<ApiResponse> removeOrder(OrdersEntity item) async {
    final responseModel =
    await remoteDataSource.removeOrder(OrdersModel.fromEntity(item));

    return ApiResponse(
      status: responseModel.status,
      message: responseModel.message,
    );
  }

  @override
  Future<ApiResponse> updateOrder(OrdersEntity item) async {
    final model = OrdersModel.fromEntity(item);
    final responseModel = await remoteDataSource.updateOrder(model);

    return ApiResponse( // لاحظ أن updateOrder في الـ remoteDataSource لا يعيد OrderModel
      status: responseModel.status,
      message: responseModel.message,
    );
  }
}