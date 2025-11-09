import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/entities/all_category_entity.dart';
import '../../../domain/entities/products_entity.dart';
import '../../../domain/entities/favorite_entity.dart';
import '../../../domain/entities/subcategory_entity.dart';
import '../../../domain/use_cases/home/category_usecase.dart';
import '../../../domain/use_cases/home/product_usecase.dart';
import '../../../domain/use_cases/favorite/get_favorites_usecase.dart';
import '../../../domain/use_cases/favorite/toggle_favorite_usecase.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  final ProductUseCase productUseCase;
  final CategoryUseCase categoryUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  HomeController(
      this.productUseCase,
      this.categoryUseCase,
      this.toggleFavoriteUseCase,
      this.getFavoritesUseCase,
      );

  StatusRequest statusRequest = StatusRequest.loading;
  TextEditingController searchController = TextEditingController();

  List<AllCategoryEntity> categories = [];
  List<SubcategoryEntity> subCategories = [];
  List<ProductEntity> products = [];
  List<ProductEntity> filteredProducts = [];

  /// المنتجات التابعة لصنف معيّن
  List<ProductEntity> categoryProducts = [];

  int selectedCategory = 0;
  List<int> favoriteProductIds = [];

  @override
  void onInit() {
    super.onInit();
    loadData();

    searchController.addListener(() {
      Future.delayed(const Duration(milliseconds: 300), filterProducts);
    });
  }

  /// تحميل البيانات (المنتجات + الفئات + المفضلة)
  Future<void> loadData() async {
    statusRequest = StatusRequest.loading;
    update();

    final categoriesResult = await categoryUseCase();
    final productsResult = await productUseCase();
    final favoritesResult = await getFavoritesUseCase();

    bool hasError = false;

    categoriesResult.fold(
          (error) {
        print("Categories error: $error");
        hasError = true;
      },
          (data) => categories = data.data ?? [],
    );

    productsResult.fold(
          (error) {
        print("Products error: $error");
        hasError = true;
      },
          (data) {
        products = data.data ?? [];
        filteredProducts = List.from(products);
      },
    );

    favoriteProductIds = favoritesResult.map((f) => f.productId).toList();

    statusRequest = hasError ? StatusRequest.failure : StatusRequest.success;
    statusRequest =filteredProducts.isEmpty?StatusRequest.nodata:StatusRequest.initial;
    update();
  }

  /// تجهيز بيانات صنف معيّن (منتجاته)
  void prepareCategoryData(int categoryId) {
    // 1️⃣ تصفية المنتجات التابعة للصنف
    categoryProducts = products
        .where((p) => p.category.parent!.id == categoryId)
        .toList();

    // 2️⃣ جلب الأصناف الفرعية من الكاتيجوري المحدد
    final category = categories.firstWhere(
          (c) => c.categoryId == categoryId,
      orElse: () => AllCategoryEntity(categoryId: 0, name: '', subcategories: []),
    );
    String categoryName=categories.firstWhere((c) =>  c.categoryId == categoryId).name;

    subCategories = List.from(category.subcategories);
    Get.toNamed(AppRoutes.categoryDetailRoute, arguments: {
      "products": categoryProducts,
      "subcategories": subCategories,
      "name": categoryName,
    });

  }

  /// اختيار صنف رئيسي
  void selectCategory(int index) {
    selectedCategory = index;
    prepareCategoryData(index);
    update();

  }

  /// فلترة المنتجات حسب البحث
  void filterProducts() {
    String query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      filteredProducts = List.from(products);
    } else {
      filteredProducts = products
          .where((p) =>
      p.productName.toLowerCase().contains(query) ||
          p.productDescription.toLowerCase().contains(query))
          .toList();
    }
    update();
  }

  /// تبديل المفضلة
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

  bool isFavorite(int productId) => favoriteProductIds.contains(productId);
}
