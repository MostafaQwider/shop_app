import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_api.dart';
import '../../../../core/constants/assets_manager.dart';
import '../../../../domain/entities/products_entity.dart';
import '../../../component/custom_cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String mainImage = product.images
        .firstWhere(
          (element) => element.is_main == true,
          orElse: () => product.images.first, // في حال ما في صورة رئيسية
        )
        .image_url;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        surfaceTintColor: Theme.of(context).backgroundColor,
        color: Theme.of(context).backgroundColor,
        elevation: .7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipPath(
                clipper: MyClipper(),
                child: CustomCachedNetworkImage(imageUrl: "${AppApi.imageUrl}/$mainImage"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${product.basePrice}\$',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap:onFavoriteToggle ,
                      child: SvgPicture.asset(isFavorite ? AssetsManager.heart:AssetsManager.heartBorder))

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(0, 0);

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);

    path.lineTo(size.width - 20, size.height - 20);
    path.quadraticBezierTo(
        size.width, size.height - 25, size.width, size.height - 50);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
