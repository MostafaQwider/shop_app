// data/models/favorite_model.dart
import 'package:shopingo/domain/entities/favorite_entity.dart';

class FavoriteModel {
  final FavoriteEntity entity;

  const FavoriteModel({required this.entity});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      entity: FavoriteEntity(productId: json['productId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': entity.productId,
    };
  }

  factory FavoriteModel.fromEntity(FavoriteEntity entity) {
    return FavoriteModel(entity: entity);
  }

  FavoriteEntity toEntity() {
    return entity;
  }
}
