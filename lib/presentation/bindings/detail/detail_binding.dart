import 'package:get/get.dart';

import '../../../domain/use_cases/cart/add_to_cart_usecase.dart';
import '../../../domain/use_cases/favorite/get_favorites_usecase.dart';
import '../../../domain/use_cases/favorite/toggle_favorite_usecase.dart';
import '../../controllers/detail/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetFavoritesUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => ToggleFavoriteUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => AddToCartUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => DetailController(Get.find(),Get.find(),Get.find()),fenix: true);
  }
}
