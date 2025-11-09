import 'dart:convert';

import 'package:get/get.dart';

import '../../core/constants/enums.dart';
import '../../core/services/api_service.dart';
import '../../core/services/storage_service.dart';
import '../models/all_category_model.dart';
import '../models/api_response.dart';
import '../models/products_model.dart';
import '../../core/constants/app_api.dart';

abstract class HomeRemoteDateSource {
  Future<ApiResponse<List<ProductModel>>> products();

  Future<ApiResponse<List<AllCategoryModel>>> categories();
}

class HomeRemoteDateSourceImpl implements HomeRemoteDateSource {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  @override
  Future<ApiResponse<List<AllCategoryModel>>> categories() async {
    final lang = await _storageService.read(key: "lang") ??
        Get.locale?.languageCode ??
        'en';

    try {
      final decodedJson = await _apiService.get(
        AppApi.categories,
        queryParams: {'lang': lang},
      );
      _storageService.write(key: "categories", value: jsonEncode(decodedJson));

      if (decodedJson is Map<String, dynamic> && decodedJson['success']) {
        final List dataList = decodedJson['data'] ?? [];
        return ApiResponse<List<AllCategoryModel>>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data:
              dataList.map((json) => AllCategoryModel.fromJson(json)).toList(),
        );
      } else {
        throw decodedJson['message'].toString().tr;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<ProductModel>>> products() async {
    final lang = await _storageService.read(key: "lang") ??
        Get.locale?.languageCode ??
        'en';

    try {
      final decodedJson = await _apiService.get(
        AppApi.products,
        queryParams: {'lang': lang},
      );

      if (decodedJson is Map<String, dynamic> && decodedJson['success']) {
        final List dataList = decodedJson['data'] ?? [];
        _storageService.write(key: "products", value: jsonEncode(decodedJson));

        return ApiResponse<List<ProductModel>>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: dataList.map((json) => ProductModel.fromJson(json)).toList(),
        );
      } else {
        throw decodedJson['message'].toString().tr;
      }
    } catch (e) {
      rethrow;
    }
  }
}
