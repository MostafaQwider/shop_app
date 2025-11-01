import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/entities/products_entity.dart';
import '../../../domain/use_cases/favorite/get_favorites_usecase.dart';
import '../../../domain/use_cases/favorite/toggle_favorite_usecase.dart';
import '../../../domain/use_cases/product/product_local_usecase.dart';
import '../../../domain/entities/favorite_entity.dart';

class FavoriteController extends GetxController {
  final ProductLocalUseCase productUseCase;
  final GetFavoritesUseCase favoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoriteController(
      this.productUseCase,
      this.favoritesUseCase,
      this.toggleFavoriteUseCase,
      );

  StatusRequest statusRequest = StatusRequest.loading;
  TextEditingController searchController = TextEditingController();

  List<ProductEntity> products = [];        // كل المنتجات من الكاش
  List<ProductEntity> favoriteProducts = []; // المنتجات المفضلة
  List<ProductEntity> filteredProducts = []; // النتائج بعد البحث
  List<int> favoriteProductIds = [];

  @override
  void onInit() {
    super.onInit();
    loadData();

    searchController.addListener(() {
      Future.delayed(const Duration(milliseconds: 300), filterProducts);
    });
  }

  /// تحميل المنتجات والمفضلة معاً
  Future<void> loadData() async {
    statusRequest = StatusRequest.loading;
    update();

    // تحميل المنتجات المحلية (الكاش)
    final productsResult = await productUseCase();
    productsResult.fold(
          (error) {
        print("Products error: $error");
        statusRequest = StatusRequest.failure;
      },
          (data) {
        products = data.data ?? [];
      },
    );

    // تحميل المفضلات
    final favorites = await favoritesUseCase();
    favoriteProductIds = favorites.map((f) => f.productId).toList();

    // فلترة المنتجات المفضلة
    applyFavoritesFilter();

    statusRequest = StatusRequest.success;
    update();
  }

  /// استخراج المنتجات المفضلة فقط
  void applyFavoritesFilter() {
    favoriteProducts = products
        .where((p) => favoriteProductIds.contains(p.id))
        .toList();
    filteredProducts = List.from(favoriteProducts);
  }

  /// فلترة حسب النص المدخل
  void filterProducts() {
    String query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      filteredProducts = List.from(favoriteProducts);
    } else {
      filteredProducts = favoriteProducts
          .where((p) =>
      p.productName.toLowerCase().contains(query) ||
          p.productDescription.toLowerCase().contains(query))
          .toList();
    }
    update();
  }

  /// تبديل حالة المفضلة لمنتج معين
  Future<void> toggleFavorite(int productId) async {
    final entity = FavoriteEntity(productId: productId);
    await toggleFavoriteUseCase(entity);

    // تحديث قائمة الـ IDs
    if (favoriteProductIds.contains(productId)) {
      favoriteProductIds.remove(productId);
    } else {
      favoriteProductIds.add(productId);
    }

    applyFavoritesFilter();
    filterProducts();
    update();
  }

  /// التحقق إذا المنتج مفضل أم لا
  bool isFavorite(int productId) => favoriteProductIds.contains(productId);
}
