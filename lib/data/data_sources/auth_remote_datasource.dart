import 'package:get/get.dart';
import '../../core/constants/app_api.dart';
import '../../core/services/api_service.dart';
import '../../core/services/storage_service.dart';
import '../models/auth_response_model.dart';
import '../models/users_model.dart';
import '../../core/constants/enums.dart';
import '../../data/models/api_response.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse<AuthResponseModel>> login(String email, String password);

  Future<ApiResponse<UsersModel>> register(UsersModel user);

  Future<ApiResponse<AuthResponseModel>> verifyAccount(
      {required String email, required String code});

  Future<ApiResponse> verifyResetCode(
      {required String email, required String code});

  Future<ApiResponse> sendVerifyCode(String email);

  Future<ApiResponse> sendResetCode(String email);

  Future<ApiResponse> resetPassword(
      {required String email, required String newPassword});

  Future<ApiResponse> changePassword(
      {required String oldPassword, required String newPassword});

  Future<ApiResponse<UsersModel>> profile();

  Future<ApiResponse<UsersModel>> updateProfile(UsersModel updatedUser);

  Future<ApiResponse<String>> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  @override
  Future<ApiResponse<AuthResponseModel>> login(
      String email, String password) async {
    try {
      final decodedJson = await _apiService.post(
        AppApi.login,
        {'email': email, 'password': password},
      );

      if (decodedJson is Map<String, dynamic>) {
        String token = decodedJson['data']['token'] ?? "";
        bool isVerified = decodedJson['data']['user']['is_verified'] ?? false;
        await _storageService.write(key: "is_verified", value: isVerified);
        await _storageService.write(key: 'token', value: token);
        await _storageService.write(key: 'isLoggedIn', value: decodedJson['success']);
        await _storageService.write(key: 'email', value: decodedJson['data']['user']['email']);

        return ApiResponse<AuthResponseModel>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: decodedJson['data'] != null
              ? AuthResponseModel.fromJson(decodedJson['data'])
              : null,
        );
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<UsersModel>> register(UsersModel user) async {
    try {
      final decodedJson = await _apiService.post(AppApi.signup, user.toJson());

      if (decodedJson is Map<String, dynamic>) {
        bool isVerified = decodedJson['data']['user']['is_verified'] ?? false;
        await _storageService.write(key: "is_verified", value: isVerified);
        await _storageService.write(key: 'isLoggedIn', value: decodedJson['success']);
        await _storageService.write(key: 'email', value: decodedJson['data']['user']['email']);

        return ApiResponse<UsersModel>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: decodedJson['data'] != null
              ? UsersModel.fromJson(decodedJson['data'])
              : null,
        );
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<AuthResponseModel>> verifyAccount(
      {required String email, required String code}) async {
    try {
      final decodedJson = await _apiService.post(
        AppApi.verifyAccount,
        {'email': email, 'code': code},
      );

      if (decodedJson is Map<String, dynamic>) {
        String token = decodedJson['data']['token'] ?? "";
        await _storageService.write(key: 'token', value: token);
        bool isVerified = decodedJson['data']['user']['is_verified'] ?? false;
        await _storageService.write(key: "is_verified", value: isVerified);
        return ApiResponse<AuthResponseModel>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: decodedJson['data'] != null
              ? AuthResponseModel.fromJson(decodedJson['data'])
              : null,
        );
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> sendVerifyCode(String email) async {
    try {
      final decodedJson =
          await _apiService.post(AppApi.sendVerificationCode, {'email': email});

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
  Future<ApiResponse> sendResetCode(String email) async {
    try {
      final decodedJson =
          await _apiService.post(AppApi.sendResetCode, {'email': email});

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
  Future<ApiResponse> resetPassword(
      {required String email, required String newPassword}) async {
    try {
      final decodedJson = await _apiService.post(AppApi.resetPassword, {
        'email': email,
        'newPassword': newPassword,
      });

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
  Future<ApiResponse> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final decodedJson = await _apiService.post(AppApi.changePassword, {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });

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
  Future<ApiResponse<UsersModel>> profile() async {
    try {
      final decodedJson = await _apiService.get(AppApi.profile);

      if (decodedJson is Map<String, dynamic>) {
        return ApiResponse<UsersModel>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: decodedJson['data'] != null
              ? UsersModel.fromJson(decodedJson['data'])
              : null,
        );
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<UsersModel>> updateProfile(UsersModel updatedUser) async {
    try {
      final decodedJson =
          await _apiService.put(AppApi.profile, updatedUser.toJson());

      if (decodedJson is Map<String, dynamic>) {
        return ApiResponse<UsersModel>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: decodedJson['data'] != null
              ? UsersModel.fromJson(decodedJson['data'])
              : null,
        );
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<String>> logout() async {
    try {
      await _storageService.remove(key: 'token');
      return ApiResponse<String>(
        status: StatusRequest.success,
        message: 'Logged out successfully',
        data: '',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> verifyResetCode(
      {required String email, required String code}) async {
    try {
      final decodedJson = await _apiService.post(
        AppApi.verifyResetCode,
        {'email': email, 'code': code},
      );
      if (decodedJson is Map<String, dynamic>) {
        return ApiResponse(
            status: decodedJson['success'] == true
                ? StatusRequest.success
                : StatusRequest.failure,
            message: decodedJson['message'].toString().tr);
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      rethrow;
    }
  }
}
