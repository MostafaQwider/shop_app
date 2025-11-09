import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/check_internet_connection.dart';
import '../../routes/app_routes.dart';
import '../../component/app_dialog.dart';
import 'dart:io';


class SplashController extends GetxController {
  final StorageService _storage = StorageService();

  @override
  void onInit() {
    super.onInit();
    checkUserStatus();
  }

  Future<void> checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    // 🟢 تحقق من الاتصال بالإنترنت
    bool hasInternet = await checkInternetConnection();
    if (!hasInternet) {
      // ❌ لا يوجد اتصال بالإنترنت، عرض مربع الحوار
      Get.dialog(
        AppDialog(
          message: "لا يوجد اتصال بالإنترنت.\nيرجى التحقق من الشبكة والمحاولة مرة أخرى.",
          cancelText: "خروج",
          confirmText: "إعادة المحاولة",
          onCancel: () => exit(0),
          onConfirm: () async {
            Get.back();
            await checkUserStatus(); // إعادة المحاولة
          },
        ),
        barrierDismissible: false,
      );
      return;
    }

    // ✅ في حال وجود اتصال، أكمل التحقق من حالة المستخدم
    final bool isLoggedIn = _storage.readTypedData<bool>(key: "isLoggedIn") ?? false;
    final bool isVerified = _storage.readTypedData<bool>(key: "is_verified") ?? false;
    final String email = _storage.read(key: "email") ?? "";
    final bool isOnBoardingComplete =
        _storage.readTypedData<bool>(key: "isOnBoardingComplete") ?? false;

    if (!isOnBoardingComplete) {
      Get.offAllNamed(AppRoutes.onboardingRoute);
    } else if (!isLoggedIn) {
      Get.offAllNamed(AppRoutes.loginRoute);
    } else if (!isVerified) {
      Get.offAllNamed(AppRoutes.verifyCodeRoute, arguments: {
        "type": "register",
        "email": email,
      });
    } else {
      Get.offAllNamed(AppRoutes.mainScreenRoute);
    }
  }
}
