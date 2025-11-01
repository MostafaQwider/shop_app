import '../../core/services/storage_service.dart';
import '../../domain/entities/favorite_entity.dart';
import '../models/favorite_model.dart';

abstract class FavoriteLocalDataSource {
  Future<void> toggleFavorite(FavoriteModel item);
  Future<List<FavoriteModel>> getFavorites();
  Future<bool> isFavorite(int productId);
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final StorageService storage = StorageService();
  static const _key = "favorite_products";

  @override
  Future<void> toggleFavorite(FavoriteModel item) async {
    final storedIds = await _getFavoriteIds();

    if (storedIds.contains(item.entity.productId)) {
      storedIds.remove(item.entity.productId);
    } else {
      storedIds.add(item.entity.productId);
    }

    await storage.write(
      key: _key,
      value: storedIds.map((e) => e.toString()).toList(),
    );
  }

  Future<List<int>> _getFavoriteIds() async {
    final data = await storage.read(key: _key);
    if (data == null) return [];
    return List<String>.from(data).map(int.parse).toList();
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    final ids = await _getFavoriteIds();
    return ids
        .map((id) => FavoriteModel(entity: FavoriteEntity(productId: id)))
        .toList();
  }

  @override
  Future<bool> isFavorite(int productId) async {
    final storedIds = await _getFavoriteIds();
    return storedIds.contains(productId);
  }
}
