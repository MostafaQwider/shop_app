class CategoryTranslationsEntity {
  final int id;
  final int category_id;
  final String language_code;
  final String name;

  CategoryTranslationsEntity({
    required this.id,
    required this.category_id,
    required this.language_code,
    required this.name,
  });
}
