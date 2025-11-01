import '../../core/services/storage_service.dart';

abstract class LangLocalDataSource {
  Future<String> getLang();

  Future<void> setLang({required String lang});
}

class LangLocalDataSourceImpl implements LangLocalDataSource {
  StorageService _storageService = StorageService();

  @override
  Future<String> getLang() async {
    return await _storageService.read(key: "lang");
  }

  @override
  Future<void> setLang({required String lang}) async {
    await _storageService.write(key: "lang", value: lang);

  }

}