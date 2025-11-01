import 'dart:convert';
import 'package:get/get.dart';
import '../../core/constants/enums.dart';
import '../../core/services/storage_service.dart';
import '../models/api_response.dart';
import '../models/products_model.dart';

abstract class ProductLocalDateSource {
  Future<ApiResponse<List<ProductModel>>> products();
}

class ProductLocalDateSourceImpl implements ProductLocalDateSource {
  final StorageService _storageService = StorageService();



  @override
  Future<ApiResponse<List<ProductModel>>> products() async {
    try {
      final data = await _storageService.read(key: "products");
      final decodedJson=jsonDecode(data);
      if (decodedJson is Map<String, dynamic>) {
        final List dataList = decodedJson['data'] ?? [];

        return ApiResponse<List<ProductModel>>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: dataList.map((json) => ProductModel.fromJson(json)).toList(),
        );
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      rethrow;
    }
  }
}
