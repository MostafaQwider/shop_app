import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  final StorageService _storage = StorageService();

  @override
  void onInit() {
    super.onInit();
    checkUserStatus();
  }

  Future<void> checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 4));

    final bool? isLoggedIn = _storage.readTypedData<bool>(key: "isLoggedIn")??false;
    final bool? isVerified = _storage.readTypedData<bool>(key: "is_verified")??false;
    final String? email = _storage.read(key: "email")??"";
    final bool? isOnBoardingComplete =
        _storage.readTypedData<bool>(key: "isOnBoardingComplete")??false;
    if (isOnBoardingComplete == null || !isOnBoardingComplete) {
      Get.offAllNamed(AppRoutes.onboardingRoute);
    } else if (isLoggedIn == null || !isLoggedIn) {
      Get.offAllNamed(AppRoutes.loginRoute);
    } else if (isVerified == null || !isVerified) {
      Get.offAllNamed(AppRoutes.verifyCodeRoute,arguments:
      {"type":"register",
      "email": email});
    } else {
       Get.offAllNamed(AppRoutes.mainScreenRoute);
    }
  }
}
