import 'dart:convert'; // للتخزين في StorageService

import 'package:get/get.dart';

import '../../core/services/api_service.dart';
import '../../core/services/storage_service.dart';
import '../models/api_response.dart';
import '../models/orders_model.dart';
import '../../core/constants/enums.dart'; // لاستخدام StatusRequest
import '../../core/constants/app_api.dart'; // لاستخدام مسارات الـ API

abstract class OrderRemoteDataSource {
  Future<ApiResponse<int>> addOrder(OrdersModel model);
  Future<ApiResponse> updateOrder(OrdersModel model);
  Future<ApiResponse> removeOrder(OrdersModel model);
  Future<ApiResponse<List<OrdersModel>>> getOrders(); // لا تتوقع model كـ parameter هنا
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  @override
  Future<ApiResponse<int>> addOrder(OrdersModel model) async {
    try {
      print(model.entity.address_id);
      final decodedJson = await _apiService.post(
        AppApi.addOrder, // افترض وجود AppApi.addOrder
        model.toJson(),
      );

      if (decodedJson is Map<String, dynamic>&&
          decodedJson.containsKey('success') &&
          decodedJson['success'] == true ) {


        return ApiResponse(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: int.parse(decodedJson['data']['id']["orderId"].toString()),
        );
      } else {
        throw decodedJson['message'].toString().tr;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> updateOrder(OrdersModel model) async {
    try {
      final decodedJson = await _apiService.put(
        AppApi.updateOrder, // افترض وجود AppApi.updateOrder
        model.toJson(),
        queryParams: {'id': model.entity.id.toString()},
      );

      return ApiResponse(
        status: decodedJson['success'] == true
            ? StatusRequest.success
            : StatusRequest.failure,
        message: decodedJson['message'].toString().tr,
      );
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<ApiResponse> removeOrder(OrdersModel model) async {
    try {
      final decodedJson = await _apiService.delete(
        AppApi.removeOrder, // افترض وجود AppApi.removeOrder
        queryParams: {'id': model.entity.id.toString()},
      );

      return ApiResponse(
        status: decodedJson['success'] == true
            ? StatusRequest.success
            : StatusRequest.failure,
        message: decodedJson['message'].toString().tr,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<OrdersModel>>> getOrders() async {
    try {
      final decodedJson = await _apiService.get(AppApi.orderForUser); // افترض وجود AppApi.getOrders

      if (decodedJson is Map<String, dynamic>&&
          decodedJson.containsKey('success') &&
          decodedJson['success'] == true) {
        final List dataList = decodedJson['data'] ?? [];
        // اختياري: تخزين الأوامر في التخزين المحلي، كما حدث مع العناوين
        _storageService.write(key: "orders", value: jsonEncode(decodedJson));
        return ApiResponse<List<OrdersModel>>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: dataList.map((json) => OrdersModel.fromJson(json)).toList(),
        );
      } else {
        throw decodedJson['message'].toString().tr;
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}