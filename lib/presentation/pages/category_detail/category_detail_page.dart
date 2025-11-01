import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/handling_data.dart';
import '../../controllers/category_detail/category_detail_controller.dart';
import '../../routes/app_routes.dart';
import '../home/component/product_card.dart';
import '../home/component/search_bar.dart';
import 'component/subcategory_chips.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryDetailController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(controller.categoryName),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GetBuilder<CategoryDetailController>(
            builder: (controller) => HandlingData(
              statusRequest: controller.statusRequest,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔍 Search Field
                  CustomSearchBar(controller: controller),

                  const SizedBox(height: 20),

                  // 🧢 Categories
                  SubCategoryChips(),

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
                          onTap: () => Get.toNamed(AppRoutes.detailRoute,
                              arguments: {"product": product}),
                          isFavorite: controller.isFavorite(product.id),
                          onFavoriteToggle: () =>
                              controller.toggleFavorite(product.id),
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
