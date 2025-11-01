import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyTranslations extends Translations {
  static final Map<String, Map<String, String>> _translations = {};

  static Future<void> loadTranslations() async {
    _translations['en'] = await _loadJson('assets/translations/en.json');
    _translations['ar'] = await _loadJson('assets/translations/ar.json');
    _translations['de'] = await _loadJson('assets/translations/de.json');
  }

  static Future<Map<String, String>> _loadJson(String path) async {
    final String data = await rootBundle.loadString(path);
    final Map<String, dynamic> jsonResult = json.decode(data);
    return jsonResult.map((key, value) => MapEntry(key, value.toString()));
  }

  @override
  Map<String, Map<String, String>> get keys => _translations;
}
