class CategoriesEntity {
  final int id;
  final CategoriesEntity? parent;
  final String name;

  CategoriesEntity({
    required this.id,
    this.parent,
    required this.name,
  });
}
