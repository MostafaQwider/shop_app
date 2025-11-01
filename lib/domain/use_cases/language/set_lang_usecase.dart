import '../../repositories/lang_repository.dart';

class SetLangUseCase {
  LangRepository repository;

  SetLangUseCase(this.repository);

  Future<void> call({required String lang}) async {
    await repository.setLang(lang: lang);
  }
}
