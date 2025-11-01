class ProductImagesEntity {
  final int id;
  final String image_url;
  final bool? is_main;

  ProductImagesEntity({
    required this.id,
    required this.image_url,
    this.is_main,
  });
}
