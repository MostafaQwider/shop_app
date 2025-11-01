class FavoriteEntity {
  final int productId;

  const FavoriteEntity({required this.productId});

  FavoriteEntity copyWith({int? productId}) {
    return FavoriteEntity(productId: productId ?? this.productId);
  }
}
