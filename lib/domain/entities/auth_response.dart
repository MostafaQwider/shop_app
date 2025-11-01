
import 'users_entity.dart';

class AuthResponse {
  final UsersEntity user;
  final String token;

  const AuthResponse({required this.user, required this.token});
}
