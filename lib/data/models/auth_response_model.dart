
import '../../domain/entities/auth_response.dart';
import 'users_model.dart';

class AuthResponseModel {
  final UsersModel user;
  final String token;

  AuthResponseModel({
    required this.user,
    required this.token,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UsersModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
    };
  }

  // تحويل الـ Model إلى Entity
  AuthResponse toEntity() {
    return AuthResponse(
      user: user.toEntity(),
      token: token,
    );
  }
}
