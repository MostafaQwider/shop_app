import '../../repositories/lang_repository.dart';

class GetLangUseCase {
  LangRepository repository;

  GetLangUseCase(this.repository);

  Future<String> call() async {
    return await repository.getLang();
  }
}
