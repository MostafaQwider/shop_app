import '../../entities/favorite_entity.dart';
import '../../repositories/favorite_repository.dart';

class ToggleFavoriteUseCase {
  final FavoriteRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> call(FavoriteEntity entity) async {
    await repository.toggleFavorite(entity);
  }
}
