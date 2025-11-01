import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingo/presentation/component/handling_data.dart';
import 'package:shopingo/presentation/pages/home/component/search_bar.dart';
import '../../controllers/main_screen_pages/favorite_controller.dart';
import '../../routes/app_routes.dart';
import '../home/component/product_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GetBuilder<FavoriteController>(
            builder: (controller) => HandlingData(
              statusRequest: controller.statusRequest,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔍 Search Field
                  CustomSearchBar(controller: controller),



                  const SizedBox(height: 20),




                  // 🛍️ Products Grid
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(top: 5),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: controller.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = controller.filteredProducts[index];
                        return ProductCard(
                          product: product,
                          onTap: () =>Get.toNamed(AppRoutes.detailRoute,arguments: {
                            "product":product
                          }),
                          isFavorite: controller.isFavorite(product.id),
                          onFavoriteToggle: ()=>controller.toggleFavorite(product.id),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
