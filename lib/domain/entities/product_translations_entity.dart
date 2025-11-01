class ProductTranslationsEntity {
  final int id;
  final int product_id;
  final String language_code;
  final String name;
  final String? description;

  ProductTranslationsEntity({
    required this.id,
    required this.product_id,
    required this.language_code,
    required this.name,
    this.description,
  });
}
