import 'dart:convert';

import 'package:get/get.dart';
import '../../core/services/api_service.dart';
import '../../core/services/storage_service.dart';
import '../models/address_model.dart';
import '../models/api_response.dart';
import '../../core/constants/enums.dart';
import '../../core/constants/app_api.dart';

abstract class AddressRemoteDataSource {
  Future<ApiResponse<AddressModel>> addAddress(AddressModel item);
  Future<ApiResponse> updateAddress(AddressModel item);
  Future<ApiResponse> removeAddress(AddressModel item);
  Future<ApiResponse<List<AddressModel>>> getAddresses();
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  @override
  Future<ApiResponse<AddressModel>> addAddress(AddressModel item) async {
    try {
      final decodedJson = await _apiService.post(
        AppApi.address,
        item.toJson(),
      );

      if (decodedJson is Map<String, dynamic>&&decodedJson['success'] ) {
        final dataJson = decodedJson['data'];
        final address = dataJson != null
            ? AddressModel.fromJson(dataJson)
            : null;

        return ApiResponse<AddressModel>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: address,
        );
      } else {
        throw decodedJson['message'].toString().tr;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> updateAddress(AddressModel item) async {
    try {
      final decodedJson = await _apiService.put(
        AppApi.address,
        item.toJson(),
        queryParams: {'id': item.entity.id.toString()},
      );

      return ApiResponse(
        status: decodedJson['success'] == true
            ? StatusRequest.success
            : StatusRequest.failure,
        message: decodedJson['message'].toString().tr ,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> removeAddress(AddressModel item) async {
    try {
      final decodedJson = await _apiService.delete(
        AppApi.address,
        queryParams: {'id': item.entity.id.toString()},
      );

      return ApiResponse(
        status: decodedJson['success'] == true
            ? StatusRequest.success
            : StatusRequest.failure,
        message: decodedJson['message'].toString().tr ,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<AddressModel>>> getAddresses() async {
    try {
      final decodedJson = await _apiService.get(AppApi.addressForUser);

      if (decodedJson is Map<String, dynamic>&&decodedJson['success'] ) {
        final List dataList = decodedJson['data'] ?? [];
        _storageService.write(key: "addresses", value: jsonEncode(decodedJson));

        return ApiResponse<List<AddressModel>>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr ,
          data: dataList.map((json) => AddressModel.fromJson(json)).toList(),
        );
      } else {
        throw decodedJson['message'].toString().tr;
      }
    } catch (e) {
      rethrow;
    }
  }
}

