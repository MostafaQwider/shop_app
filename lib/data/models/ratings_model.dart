
import '../../domain/entities/ratings_entity.dart';

class RatingsModel {
  final RatingsEntity entity;

  RatingsModel({required this.entity});

  factory RatingsModel.fromJson(Map<String, dynamic> json) {
    return RatingsModel(
      entity: RatingsEntity(
        id: json['id'],
        user_id: json['user_id'],
        product_id: json['product_id'],
        rating: json['rating'],
        comment: json['comment'],
        created_at: DateTime.tryParse(json['created_at'] ?? ''),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'user_id': entity.user_id,
      'product_id': entity.product_id,
      'rating': entity.rating,
      'comment': entity.comment,
      'created_at': entity.created_at?.toIso8601String(),
    };
  }

  factory RatingsModel.fromEntity(RatingsEntity entity) {
    return RatingsModel(entity: entity);
  }

  RatingsEntity toEntity() {
    return entity;
  }
}
