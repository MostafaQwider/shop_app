
import '../../domain/entities/favorite_entity.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../data_sources/favorite_local_data_source.dart';
import '../models/favorite_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;

  FavoriteRepositoryImpl(this.localDataSource);

  @override
  Future<void> toggleFavorite(FavoriteEntity entity) async {
    final model = FavoriteModel.fromEntity(entity);
    await localDataSource.toggleFavorite(model);
  }

  @override
  Future<List<FavoriteEntity>> getFavorites() async {
    final list = await localDataSource.getFavorites();
    return list.map((e) => e.toEntity()).toList();
  }

  @override
  Future<bool> isFavorite(int productId) {
    return localDataSource.isFavorite(productId);
  }
}
