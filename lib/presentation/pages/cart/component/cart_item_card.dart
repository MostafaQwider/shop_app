import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_api.dart';
import '../../../../domain/entities/products_entity.dart';
import '../../../component/custom_cached_network_image.dart';
import '../../../controllers/main_screen_pages/cart_controller.dart';

class CartItemCard extends StatelessWidget {
  final ProductEntity product;
  final int quantity;

  const CartItemCard({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    final variant = product.variants.first;
    final colorValue = variant.color.name; // ← يحتوي على كود اللون (#FF5733)
    final color = Color(int.parse(colorValue.replaceFirst('#', '0xff')));
    String mainImage = product.images
        .firstWhere(
          (element) => element.is_main == true,
          orElse: () => product.images.first, // في حال ما في صورة رئيسية
        )
        .image_url;
    return SizedBox(
      height: Get.height / 4,
      width: Get.width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        surfaceTintColor: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: Get.width / 3.5,
                    height: Get.height,
                    child: CustomCachedNetworkImage(
                        imageUrl: "${AppApi.imageUrl}/$mainImage"),
                  )),
              const SizedBox(width: 12),

              // 📄 تفاصيل المنتج
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      product.productName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text("Size: ",
                            style: TextStyle(color: Colors.grey)),
                        Text(variant.size.name),
                        const SizedBox(width: 12),
                        const Text("Color: ",
                            style: TextStyle(color: Colors.grey)),
                        CircleAvatar(radius: 8, backgroundColor: color),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${product.basePrice.toStringAsFixed(2)} \$",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                surfaceTintColor: Theme.of(context).cardColor,
                elevation: 3,
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        controller.addToCart(product);
                      },
                    ),
                    Text(
                      "$quantity",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(quantity > 1
                          ? Icons.remove_circle_outline
                          : CupertinoIcons.delete_solid),
                      onPressed: () => quantity > 1
                          ? controller.minesQuantityFromCart(product)
                          : controller.removeFromCart(product),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
