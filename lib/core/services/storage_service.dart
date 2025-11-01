import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;

  late SharedPreferences _prefs;

  StorageService._internal();

  /// يجب استدعاؤه مرة واحدة عند بدء التشغيل (في main.dart)
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// حفظ البيانات بمختلف أنواعها
  Future<bool?> write({
    required String key,
    required dynamic value,
  }) async {
    try {
      if (value is bool) {
        return await _prefs.setBool(key, value);
      } else if (value is String) {
        return await _prefs.setString(key, value);
      } else if (value is int) {
        return await _prefs.setInt(key, value);
      } else if (value is double) {
        return await _prefs.setDouble(key, value);
      } else if (value is List<String>) {
        return await _prefs.setStringList(key, value);
      }
      return null;
    } catch (e) {
      throw StorageException('Failed to save data: $e');
    }
  }

  /// قراءة البيانات
  dynamic read({required String key}) {
    try {
      return _prefs.get(key);
    } catch (e) {
      throw StorageException('Failed to read data: $e');
    }
  }

  /// قراءة بيانات مع نوع محدد
  T? readTypedData<T>({required String key}) {
    try {
      return _prefs.get(key) as T?;
    } catch (e) {
      throw StorageException('Failed to read typed data: $e');
    }
  }

  /// حذف عنصر محدد
  Future<bool> remove({required String key}) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      throw StorageException('Failed to remove data: $e');
    }
  }

  /// مسح جميع البيانات المحفوظة
  Future<bool> clearAll() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      throw StorageException('Failed to clear storage: $e');
    }
  }

  /// التحقق من وجود مفتاح
  bool containsKey(String key) {
    try {
      return _prefs.containsKey(key);
    } catch (e) {
      throw StorageException('Failed to check key: $e');
    }
  }
}

class StorageException implements Exception {
  final String message;
  StorageException(this.message);

  @override
  String toString() => 'StorageException: $message';
}