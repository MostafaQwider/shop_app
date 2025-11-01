import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../core/services/storage_service.dart';
import '../../../domain/use_cases/auth/logout_usecase.dart';
import '../../../domain/use_cases/auth/profile_usecase.dart';
import '../../../domain/use_cases/language/set_lang_usecase.dart';
import '../../component/app_snack_bar.dart';
import '../../routes/app_routes.dart';

class SettingsController extends GetxController {
  ProfileUseCase profileUseCase;
  LogoutUseCase logoutUseCase;
  SetLangUseCase setLangUseCase;

  SettingsController(this.profileUseCase, this.logoutUseCase,this.setLangUseCase);

  // Observables لإدارة حالة الفتح/الإغلاق لكل قسم
  var isAccountSettingsExpanded = false.obs;
  var isLanguageSettingsExpanded = false.obs;
  StatusRequest statusRequest = StatusRequest.loading;
  String name = "",
      email = "";

   StorageService storageService=StorageService();
   // قائمة اللغات المتاحة (يمكنك توسيعها)
  final List<String> availableLanguages = ['ar', 'en', 'de'];
  var selectedLanguage = 'ar'.obs; // اللغة الافتراضية

  // تبديل حالة الفتح/الإغلاق لإعدادات الحساب
  void toggleAccountSettings() {
    isAccountSettingsExpanded.value = !isAccountSettingsExpanded.value;
  }

  // تبديل حالة الفتح/الإغلاق لإعدادات اللغة
  void toggleLanguageSettings() {
    isLanguageSettingsExpanded.value = !isLanguageSettingsExpanded.value;
  }

  // لتغيير اللغة المحددة
  void changeLanguage(String langCode) async{
    await setLangUseCase(lang: langCode);
    Get.deleteAll();
    Get.offAllNamed(AppRoutes.splashRoute);

  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    final result = await profileUseCase();
    result.fold((l) => null, (r) {
      name = r.data!.name;
      email = r.data!.email;
    });
    statusRequest = StatusRequest.initial;
    update();
  }

  Future<void> logout() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await logoutUseCase();
    result.fold((l) => showToastMessage(label: '', text: l)
        , (r) {
          showToastMessage(label: '', text: r.message ?? "");
          Get.deleteAll();
          Get.offAllNamed(AppRoutes.loginRoute);
        });
    statusRequest = StatusRequest.initial;
    update();
  }
}