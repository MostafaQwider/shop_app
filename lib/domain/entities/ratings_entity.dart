class RatingsEntity {
  final int id;
  final int user_id;
  final int product_id;
  final int? rating;
  final String? comment;
  final DateTime? created_at;

  RatingsEntity({
    required this.id,
    required this.user_id,
    required this.product_id,
    this.rating,
    this.comment,
    this.created_at,
  });
}
