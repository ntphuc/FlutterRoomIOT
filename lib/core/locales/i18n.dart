import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class I18n {
  I18n(this.locale);

  final String _baseUri = 'assets/locales/';
  final Locale locale;

  static I18n of(BuildContext context) => Localizations.of<I18n>(context, I18n);

  static const LocalizationsDelegate<I18n> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _resources;

  Future<bool> load() async {
    final jsonString =
        await rootBundle.loadString('$_baseUri${locale.languageCode}.json');
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    _resources = jsonMap.map((String key, dynamic value) =>
        MapEntry<String, String>(key, value.toString()));
    return true;
  }

  String translate(String key) => _resources[key];
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<I18n> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  Future<I18n> load(Locale locale) async {
    final I18n localizations = I18n(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<I18n> old) => false;
}
