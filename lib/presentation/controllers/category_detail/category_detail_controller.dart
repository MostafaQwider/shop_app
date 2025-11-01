import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/entities/products_entity.dart';
import '../../../domain/entities/subcategory_entity.dart';
import '../../../domain/entities/favorite_entity.dart';
import '../../../domain/use_cases/favorite/get_favorites_usecase.dart';
import '../../../domain/use_cases/favorite/toggle_favorite_usecase.dart';

class CategoryDetailController extends GetxController {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  CategoryDetailController(
      this.getFavoritesUseCase,
      this.toggleFavoriteUseCase,
      );

  /// 🔍 البحث
  TextEditingController searchController = TextEditingController();

  /// 🔁 الحالة العامة
  StatusRequest statusRequest = StatusRequest.loading;

  /// 🧩 البيانات المستلمة من Get.arguments
  late List<ProductEntity> allProducts;
  late List<SubcategoryEntity> subcategories;

  /// 🔍 المنتجات المفلترة
  List<ProductEntity> filteredProducts = [];

  /// ❤️ المفضلة
  List<int> favoriteProductIds = [];

  /// 🧠 الصنف الفرعي المحدد حاليًا
  int selectedSubcategoryId=-1;
  String categoryName="";

  @override
  void onInit() {
    super.onInit();

    // 📦 استقبال البيانات من الصفحة السابقة
    final args = Get.arguments;
    allProducts = args["products"] ?? [];
    subcategories = args["subcategories"] ?? [];
    categoryName = args["name"] ?? '';

    filteredProducts = List.from(allProducts);
    checkData();
    loadFavorites();

    // ⌛ تأخير بسيط لتصفية البحث
    searchController.addListener(() {
      Future.delayed(const Duration(milliseconds: 300), filterProducts);
    });
  }

  /// 🧠 تحميل المفضلات
  Future<void> loadFavorites() async {
    final result = await getFavoritesUseCase();
    favoriteProductIds = result.map((f) => f.productId).toList();

    statusRequest = StatusRequest.initial;
    update();
  }

  /// 🔁 تبديل حالة المفضلة
  Future<void> toggleFavorite(int productId) async {
    final entity = FavoriteEntity(productId: productId);
    await toggleFavoriteUseCase(entity);

    if (favoriteProductIds.contains(productId)) {
      favoriteProductIds.remove(productId);
    } else {
      favoriteProductIds.add(productId);
    }
    update();
  }

  /// ✅ التحقق من كون المنتج مفضل
  bool isFavorite(int productId) => favoriteProductIds.contains(productId);

  /// 🔍 فلترة المنتجات حسب البحث أو الصنف الفرعي المحدد
  void filterProducts() {
    final query = searchController.text.toLowerCase();

    List<ProductEntity> temp = List.from(allProducts);

    // 📂 أولاً فلترة حسب الصنف الفرعي (إن وجد)
    if (selectedSubcategoryId != -1) {
      temp = temp
          .where((p) => p.category.id == selectedSubcategoryId)
          .toList();
    }

    // 🔍 بعدها فلترة حسب نص البحث
    if (query.isNotEmpty) {
      temp = temp
          .where((p) =>
      p.productName.toLowerCase().contains(query) ||
          p.productDescription.toLowerCase().contains(query))
          .toList();
    }

    filteredProducts = temp;
    checkData();
    update();
  }
  void checkData(){
    if(filteredProducts.isEmpty)
      statusRequest=StatusRequest.nodata;
  }
  /// 🧩 عند اختيار صنف فرعي جديد
  void selectSubcategory(int subcategoryId) {
    selectedSubcategoryId = subcategoryId;
    filterProducts();
  }

  /// إلغاء تحديد الصنف الفرعي
  void clearSubcategory() {
    selectedSubcategoryId = -1;
    filterProducts();
  }
}
