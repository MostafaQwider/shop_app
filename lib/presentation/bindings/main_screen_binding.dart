import 'package:get/get.dart';
import '../../domain/use_cases/address/get_address_usecase.dart';
import '../../domain/use_cases/auth/logout_usecase.dart';
import '../../domain/use_cases/auth/profile_usecase.dart';
import '../../domain/use_cases/cart/add_to_cart_usecase.dart';
import '../../domain/use_cases/cart/clear_cart_usecase.dart';
import '../../domain/use_cases/cart/get_cart_usecase.dart';
import '../../domain/use_cases/cart/mines_quantity_usecase.dart';
import '../../domain/use_cases/cart/remove_cart_item_usecase.dart';
import '../../domain/use_cases/favorite/get_favorites_usecase.dart';
import '../../domain/use_cases/home/category_usecase.dart';
import '../../domain/use_cases/home/product_usecase.dart';
import '../../domain/use_cases/language/set_lang_usecase.dart';
import '../../domain/use_cases/orders/get_orders_usecase.dart';
import '../../domain/use_cases/orders/remove_orders_usecase.dart';
import '../../presentation/controllers/main_screen_pages/home_controller.dart';
import '../../domain/use_cases/favorite/toggle_favorite_usecase.dart';
import '../../domain/use_cases/product/product_local_usecase.dart';
import '../controllers/main_screen_pages/cart_controller.dart';
import '../controllers/main_screen_pages/favorite_controller.dart';
import '../controllers/main_screen_pages/order/order_controller.dart';
import '../controllers/main_screen_pages/settings_controller.dart';

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => ProductUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => ProductLocalUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetFavoritesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => ToggleFavoriteUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetCartUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => RemoveCartItemUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => AddToCartUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => MinesQuantityCartUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetAddressUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetOrderUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => RemoveOrderUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => ProfileUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LogoutUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => ClearCartUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SetLangUseCase(Get.find()), fenix: true);

    Get.lazyPut(() => FavoriteController(Get.find(), Get.find(), Get.find()),
        fenix: true);

    Get.lazyPut(
        () => HomeController(Get.find(), Get.find(), Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(
        () => CartController(Get.find(), Get.find(), Get.find(), Get.find(),
            Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(
        () => OrderController(Get.find(), Get.find(), Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(
            () => SettingsController(Get.find(),Get.find(),Get.find()),
        fenix: true);
  }
}
