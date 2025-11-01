// domain/repositories/favorite_repository.dart
import '../entities/favorite_entity.dart';

abstract class FavoriteRepository {
  Future<void> toggleFavorite(FavoriteEntity entity);
  Future<List<FavoriteEntity>> getFavorites();
  Future<bool> isFavorite(int productId);
}
