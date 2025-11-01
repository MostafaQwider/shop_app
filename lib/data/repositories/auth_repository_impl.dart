import '../../domain/entities/auth_response.dart';
import '../../domain/entities/users_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_datasource.dart';
import '../models/api_response.dart';
import '../models/users_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResponse<AuthResponse>> login(String email, String password) async {
    final responseModel = await remoteDataSource.login(email, password);

    if (responseModel.data != null) {
      return ApiResponse<AuthResponse>(
        status: responseModel.status,
        data: responseModel.data!.toEntity(),
        message: responseModel.message,
      );
    } else {
      return ApiResponse<AuthResponse>(
        status: responseModel.status,
        message: responseModel.message,
      );
    }
  }

  @override
  Future<ApiResponse<UsersEntity>> register(UsersEntity user) async {
    final userModel = UsersModel.fromEntity(user);
    final responseModel = await remoteDataSource.register(userModel);

    if (responseModel.data != null) {
      return ApiResponse<UsersEntity>(
        status: responseModel.status,
        data: responseModel.data!.toEntity(),
        message: responseModel.message,
      );
    } else {
      return ApiResponse<UsersEntity>(
        status: responseModel.status,
        message: responseModel.message,
      );
    }
  }

  @override
  Future<ApiResponse<AuthResponse>> verifyAccount({required String email, required String code}) async {
    final responseModel = await remoteDataSource.verifyAccount(email: email, code: code);

    if (responseModel.data != null) {
      return ApiResponse<AuthResponse>(
        status: responseModel.status,
        data: responseModel.data!.toEntity(),
        message: responseModel.message,
      );
    } else {
      return ApiResponse<AuthResponse>(
        status: responseModel.status,
        message: responseModel.message,
      );
    }
  }

  @override
  Future<ApiResponse> sendVerifyCode(String email) => remoteDataSource.sendVerifyCode(email);

  @override
  Future<ApiResponse> sendResetCode(String email) => remoteDataSource.sendResetCode(email);

  @override
  Future<ApiResponse> resetPassword({required String email, required String newPassword}) =>
      remoteDataSource.resetPassword(email: email, newPassword: newPassword);

  @override
  Future<ApiResponse> changePassword({required String oldPassword, required String newPassword}) =>
      remoteDataSource.changePassword(oldPassword: oldPassword, newPassword: newPassword);

  @override
  Future<ApiResponse<UsersEntity>> profile() async {
    final responseModel = await remoteDataSource.profile();
    if (responseModel.data != null) {
      return ApiResponse<UsersEntity>(
        status: responseModel.status,
        data: responseModel.data!.toEntity(),
        message: responseModel.message,
      );
    } else {
      return ApiResponse<UsersEntity>(
        status: responseModel.status,
        message: responseModel.message,
      );
    }
  }

  @override
  Future<ApiResponse<UsersEntity>> updateProfile(UsersEntity updatedUser) async {
    final userModel = UsersModel.fromEntity(updatedUser);
    final responseModel = await remoteDataSource.updateProfile(userModel);
    if (responseModel.data != null) {
      return ApiResponse<UsersEntity>(
        status: responseModel.status,
        data: responseModel.data!.toEntity(),
        message: responseModel.message,
      );
    } else {
      return ApiResponse<UsersEntity>(
        status: responseModel.status,
        message: responseModel.message,
      );
    }
  }

  @override
  Future<ApiResponse<String>> logout() => remoteDataSource.logout();

  @override
  Future<ApiResponse> verifyResetCode({required String email, required String code})
  => remoteDataSource.verifyResetCode(email: email, code: code);

}
