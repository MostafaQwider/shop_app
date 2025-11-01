class AppApi {
  static const String imageUrl =
      'https://4dd4057f8501.ngrok-free.app/uploads/';
  static const String server =
      'https://4dd4057f8501.ngrok-free.app/api/v1';

// ================================= AUTH ========================== //

  static const String signup = "auth/register";
  static const String login = "auth/login";
  static const String profile = "users/profile";
  // تفعيل الحساب
  static const String verifyAccount = "auth/verify-account";
  static const String sendVerificationCode = "auth/send-verification-code";
  // نسيت كلمة المرور
  static const String sendResetCode = "auth/send-reset-code";
  static const String resetPassword = "auth/reset-password";
  static const String verifyResetCode = "auth/verify-reset-code";

  static const String changePassword = "auth/change-password";
  static const String logout = "auth/logout";

// ================================================================ //

  static const String categories = "categories/allcategories";
  static const String products = "products/details";
  static const String address = "addresses";
  static const String addressForUser = "addresses/all";
  static const String addOrder = "orders";
  static const String updateOrder = "orders/update";
  static const String removeOrder = "orders/delete";
  static const String orderForUser = "orders";


}
