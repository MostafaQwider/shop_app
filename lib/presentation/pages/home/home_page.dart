import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/strings.dart';
import '../../component/handling_data.dart';
import '../../controllers/main_screen_pages/home_controller.dart';
import '../../routes/app_routes.dart';
import 'component/category_chips.dart';
import 'component/product_card.dart';
import 'component/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GetBuilder<HomeController>(
            builder: (controller) => HandlingData(
              onTryAgain: controller.loadData,
              statusRequest: controller.statusRequest,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔍 Search Field
                  CustomSearchBar(controller: controller),

                  const SizedBox(height: 20),

                  // 🧢 Categories
                  CategoryChips(
                    categories: controller.categories,
                    selectedIndex: -1,
                    onCategorySelected: controller.selectCategory,
                  ),

                  const SizedBox(height: 20),

                  // 🛍️ Section Title
                  Text(
                    AppStrings.newArrivals.tr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                  ),

                  const SizedBox(height: 15),

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
