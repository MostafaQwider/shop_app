abstract class LangRepository {
  Future<String> getLang();
  Future<void> setLang({required String lang});
}
