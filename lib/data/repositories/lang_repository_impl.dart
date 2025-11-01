

import '../../domain/repositories/lang_repository.dart';
import '../data_sources/lang_local_datasource.dart';

class LangRepositoryImpl implements LangRepository{
  LangLocalDataSource langLocalDataSource;
  LangRepositoryImpl(this.langLocalDataSource);
  @override
  Future<String> getLang() async{
  return await langLocalDataSource.getLang();
  }

  @override
  Future<void> setLang({required String lang}) async{
   await langLocalDataSource.setLang(lang: lang);
  }
}