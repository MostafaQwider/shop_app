import 'package:get/get.dart';
import '../bindings/auth/change_password_binding.dart';
import '../bindings/auth/forget_password_binding.dart';
import '../bindings/auth/login_binding.dart';
import '../bindings/auth/reset_password_binding.dart';
import '../bindings/auth/signup_binding.dart';
import '../bindings/auth/verify_code_binding.dart';
import '../bindings/category_detail/category_detail_binding.dart';
import '../bindings/checkout/checkout_binding.dart';
import '../bindings/detail/detail_binding.dart';
import '../bindings/main_screen_binding.dart';
import '../bindings/onboarding/on_boarding_binding.dart';
import '../bindings/order_detail/order_detail_binding.dart';
import '../bindings/setting/address_binding.dart';
import '../bindings/setting/option_address_binding.dart';
import '../pages/auth/change_password_page.dart';
import '../pages/auth/forget_password_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/reset_password_page.dart';
import '../pages/auth/signup_page.dart';
import '../pages/auth/splash_page.dart';
import '../pages/auth/verify_code_page.dart';
import '../pages/category_detail/category_detail_page.dart';
import '../pages/checkout/checkout_page.dart';
import '../pages/checkout/payment_page.dart';
import '../pages/detail/detail_page.dart';
import '../pages/main_screen.dart';
import '../pages/onboarding/on_boarding_screen.dart';
import '../pages/order/order_detail_page.dart';
import '../pages/setting/address_page.dart';
import '../pages/setting/option_address_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    //==========================AUTH=========================
    GetPage(name: AppRoutes.splashRoute, page: () => const SplashPage()),
    GetPage(
        name: AppRoutes.loginRoute,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.signupRoute,
        page: () => const SignupPage(),
        binding: SignupBinding()),
    GetPage(
        name: AppRoutes.forgetPasswordRoute,
        page: () => const ForgetPasswordPage(),
        binding: ForgetPasswordBinding()),
    GetPage(
        name: AppRoutes.onboardingRoute,
        page: () => const OnBoardingPage(),
        binding: OnBoardingBinding()),
    GetPage(
        name: AppRoutes.verifyCodeRoute,
        page: () => const VerifyCodePage(),
        binding: VerifyCodeBinding()),
    GetPage(
        name: AppRoutes.changePasswordRoute,
        page: () => const ChangePasswordPage(),
        binding: ChangePasswordBinding()),
    GetPage(
        name: AppRoutes.mainScreenRoute,
        page: () => const MainScreen(),
        binding: MainScreenBinding()),

    GetPage(
        name: AppRoutes.detailRoute,
        page: () => const DetailPage(),
        binding: DetailBinding()),
    GetPage(
        name: AppRoutes.categoryDetailRoute,
        page: () => const CategoryDetailPage(),
        binding: CategoryDetailBinding()),
    GetPage(
        name: AppRoutes.optionAddressRoute,
        page: () => const OptionAddressPage(),
        binding: OptionAddressBinding()),

    GetPage(
        name: AppRoutes.addressRoute,
        page: () => const AddressPage(),
        binding: AddressBinding()),
    GetPage(
        name: AppRoutes.checkoutRoute,
        page: () => const CheckoutPage(),
        binding: CheckOutBinding()),
    GetPage(
        name: AppRoutes.orderDetailRoute,
        page: () => const OrderDetailPage(),
        binding: OrderDetailBinding()),
    GetPage(
        name: AppRoutes.resetPasswordRoute,
        page: () => const ResetPasswordPage(),
        binding: ResetPasswordBinding()),
    GetPage(
        name: AppRoutes.paymentRoute,
        page: () => const PaymentPage(),
        binding: CheckOutBinding()),
  ];
}
