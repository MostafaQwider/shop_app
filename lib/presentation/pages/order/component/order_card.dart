import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopingo/core/constants/app_api.dart';
import 'package:shopingo/core/constants/strings.dart';
import 'package:shopingo/domain/entities/order_products_entity.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderProductsEntity order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        surfaceTintColor: Theme.of(context).cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // التاريخ في الأعلى
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      order.order.created_at!.split("T")[0],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Tooltip(
                      message: "Order ID",
                      child: Text(
                        "#${order.order.id}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )

                ],
              ),
              const SizedBox(height: 10),

              // قائمة المنتجات
              ListView.builder(
                shrinkWrap: true,
                // مهم لعرض ListView داخل Column/Card
                physics: const NeverScrollableScrollPhysics(),
                // منع التمرير داخل ListView
                itemCount: order.product.length,
                itemBuilder: (context, index) {
                  final product = order.product[index];
                  final image =
                      "${AppApi.imageUrl}/${order.product[index].images.firstWhere((element) => element.is_main!).image_url}";

                  // لتقصير اسم المنتج إذا كان طويلاً
                  final String productName = product.productName.length > 25
                      ? '${product.productName.substring(0, 22)}...'
                      : product.productName;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        // صورة المنتج
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200], // لون خلفية افتراضي
                          ),
                          child: product.images.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            Colors.white, // لون الشيمر الأساسي
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey[200],
                                    ),
                                    child: Icon(Icons.image_not_supported,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                )
                              : Icon(Icons.image,
                                  color: Theme.of(context)
                                      .primaryColor), // في حال عدم وجود صور
                        ),
                        const SizedBox(width: 10),
                        // اسم المنتج x الكمية
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'x ${product.quantity}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // السعر
                        Text(
                          '${product.basePrice.toStringAsFixed(2)}\$',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(height: 25, thickness: 1),
              // الإجمالي
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.total.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${order.order.total.toStringAsFixed(2)}\$',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
