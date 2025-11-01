import '../../data/models/api_response.dart';
import '../entities/auth_response.dart';
import '../entities/users_entity.dart';

abstract class AuthRepository {
  /// تسجيل الدخول (email + password)
  Future<ApiResponse<AuthResponse>> login(String email, String password);

  /// إنشاء حساب جديد (name + email + password)
  Future<ApiResponse<UsersEntity>> register(UsersEntity user);

  /// تفعيل الحساب بعد التسجيل (email + code)
  Future<ApiResponse<AuthResponse>> verifyAccount({
    required String email,
    required String code,
  });
  Future<ApiResponse> verifyResetCode({
    required String email,
    required String code,
  });

  /// إرسال كود التحقق لتفعيل الحساب (email)
  Future<ApiResponse> sendVerifyCode(String email);

  /// إرسال كود استعادة كلمة المرور (email)
  Future<ApiResponse> sendResetCode(String email);

  /// إعادة تعيين كلمة المرور بعد إدخال الكود
  Future<ApiResponse> resetPassword({
    required String email,
    required String newPassword,
  });

  /// تغيير كلمة المرور بعد تسجيل الدخول
  Future<ApiResponse> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  /// جلب بيانات المستخدم الحالية من التوكن
  Future<ApiResponse<UsersEntity>> profile();

  /// تحديث بيانات المستخدم (مثل الاسم أو الصورة أو البريد)
  Future<ApiResponse<UsersEntity>> updateProfile(UsersEntity updatedUser);

  /// تسجيل الخروج
  Future<ApiResponse> logout();
}
