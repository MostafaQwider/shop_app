import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopingo/core/constants/app_api.dart';
import 'package:shopingo/domain/entities/product_images_entity.dart';
import 'package:shopingo/presentation/component/custom_cached_network_image.dart';

class ProductImageCarousel extends StatelessWidget {
  final List<ProductImagesEntity> images;

  const ProductImageCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return CustomCachedNetworkImage(
            imageUrl: "${AppApi.imageUrl}/${images[index].image_url}");
      },
      options: CarouselOptions(
        height: 350,
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        viewportFraction: 1.0,
      ),
    );
  }
}
