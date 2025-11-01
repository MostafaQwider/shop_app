import 'dart:convert';
import '../../core/services/storage_service.dart';
import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<void> addCartItem(CartItemModel item);
  Future<void> minesQuantityFromCart(CartItemModel item);
  Future<List<CartItemModel>> getCartItems();
  Future<void> removeCartItem(CartItemModel item);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final StorageService storage = StorageService();
  static const _key = "cart_items";

  /// جلب البيانات من الكاش كـ List<Map<String, dynamic>>
  Future<List<Map<String, dynamic>>> _getRawCartData() async {
    final storedValue = await storage.read(key: _key);

    if (storedValue == null) return [];

    try {
      final decoded = jsonDecode(storedValue); // List<dynamic>

      if (decoded is List) {
        return decoded
            .map<Map<String, dynamic>>(
                (e) => e is Map ? Map<String, dynamic>.from(e) : {})
            .toList();
      }
    } catch (e) {
      return [];
    }

    return [];
  }

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final rawData = await _getRawCartData();
    return rawData.map((e) => CartItemModel.fromJson(e)).toList();
  }

  @override
  Future<void> addCartItem(CartItemModel item) async {
    final stored = await getCartItems();
    final existingIndex = stored.indexWhere(
            (i) =>
        i.entity.productId == item.entity.productId &&
            i.entity.colorId == item.entity.colorId &&
            i.entity.sizeId == item.entity.sizeId);

    if (existingIndex != -1) {
      // تحديث الكمية
      final existing = stored[existingIndex].entity;
      stored[existingIndex] = CartItemModel.fromEntity(
          existing.copyWith(quantity: existing.quantity + 1));
    } else {
      stored.add(item);
    }
    // تخزين السلة بصيغة JSON
    final rawList = stored.map((e) => e.toJson()).toList();
    print(jsonEncode(rawList));
    await storage.write(key: _key, value: jsonEncode(rawList));

  }

  @override
  Future<void> removeCartItem(CartItemModel item) async {
    final stored = await getCartItems();

    stored.removeWhere((i) =>
    i.entity.productId == item.entity.productId &&
        i.entity.colorId == item.entity.colorId &&
        i.entity.sizeId == item.entity.sizeId);

    final rawList = stored.map((e) => e.toJson()).toList();
    await storage.write(key: _key, value: jsonEncode(rawList));
  }

  @override
  Future<void> clearCart() async {
    await storage.write(key: _key, value: jsonEncode([]));
  }

  @override
  Future<void> minesQuantityFromCart(CartItemModel item) async{
    final stored = await getCartItems();
    final existingIndex = stored.indexWhere(
            (i) =>
        i.entity.productId == item.entity.productId &&
            i.entity.colorId == item.entity.colorId &&
            i.entity.sizeId == item.entity.sizeId);

    if (existingIndex != -1) {
      // تحديث الكمية
      final existing = stored[existingIndex].entity;
      stored[existingIndex] = CartItemModel.fromEntity(
          existing.copyWith(quantity: existing.quantity -1));
    } else {
      stored.add(item);
    }
    // تخزين السلة بصيغة JSON
    final rawList = stored.map((e) => e.toJson()).toList();
    print(jsonEncode(rawList));
    await storage.write(key: _key, value: jsonEncode(rawList));
  }
}
