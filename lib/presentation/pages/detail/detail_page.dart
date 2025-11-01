import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../component/app_button.dart';
import '../../controllers/detail/detail_controller.dart';
import 'component/clipper.dart';
import 'component/image_slider.dart';
import 'component/select_color.dart';
import 'component/select_size.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    DetailController controller=Get.find();
    return Scaffold(
      body: GetBuilder<DetailController>(
        builder: (controller) => ListView(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  ProductImageCarousel(images: controller.images),
                  Positioned(
                    top: 5,
                    right: 15,
                    child: GestureDetector(
                        onTap: () => Get.back(),
                        child: SvgPicture.asset(
                          AssetsManager.arrowRight,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.product.productName,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        '\$${controller.product.basePrice}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                  Obx(() => GestureDetector(
                      onTap: controller.toggleFavorite,
                      child: SvgPicture.asset(controller.isFavorite.value
                          ? AssetsManager.heart
                          : AssetsManager.heartBorder))),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppStrings.selectSize.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            DetailScreenSelectSize(
              controller: controller,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppStrings.selectColor.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            DetailScreenSelectColor(
              controller: controller,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppStrings.description.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                controller.product.productDescription,
                style: const TextStyle(color: AppColor.grey),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: AppButton(
            text: AppStrings.addToCart.tr,
            onPressed:controller.addToCart , // أضف الأكشن هون
          ),
        ),
      ),
    );
  }
}
