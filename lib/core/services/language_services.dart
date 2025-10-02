import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LocalizationService extends Translations {
  static final fallbackLocale = Locale('en', 'US');
  static const Locale defaultLocale = Locale('en', 'US');

  static final locales = [
    Locale('en', 'US'),
    Locale('ar', 'SA'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
    Locale('ru', 'RU'),
    Locale('it', 'IT'),
    Locale('pt', 'PT'),
    Locale('ms', 'MY'),
    Locale('pl', 'PL'),
    Locale('es', 'ES'),
    Locale('zh', 'CN'),
    Locale('ja', 'JP'),
    Locale('id', 'ID'),
  ];

  // 👇 Add this static variable to store loaded keys
  static Map<String, Map<String, String>> translations = {};

  static Future<void> loadTranslations() async {
    for (var locale in locales) {
      final String jsonString =
      await rootBundle.loadString('assets/language/${locale.languageCode}.json');

      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      translations['${locale.languageCode}_${locale.countryCode}'] =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
    }
  }

  // 👇 Return the loaded translations
  @override
  Map<String, Map<String, String>> get keys => translations;
}
