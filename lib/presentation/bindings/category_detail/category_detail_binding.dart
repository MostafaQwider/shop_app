import 'package:get/get.dart';
import '../../../domain/use_cases/favorite/get_favorites_usecase.dart';
import '../../../domain/use_cases/favorite/toggle_favorite_usecase.dart';
import '../../controllers/category_detail/category_detail_controller.dart';

class CategoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetFavoritesUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => ToggleFavoriteUseCase(Get.find()),fenix: true);
    Get.lazyPut(() => CategoryDetailController(Get.find(), Get.find()),fenix: true);
  }
}
