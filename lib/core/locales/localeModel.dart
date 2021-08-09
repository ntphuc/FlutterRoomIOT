import 'package:flutter/material.dart';

const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('vi')];

const List<AppLocale> appLocales = <AppLocale>[
  AppLocale.English,
  AppLocale.Vietnamese
];

enum AppLocale { English, Vietnamese }

class LocaleModel extends ChangeNotifier {
  AppLocale appLocale = AppLocale.Vietnamese;
  Locale currentLocale = supportedLocales[1];

  void toggleLocale(AppLocale newAppLocale) {
    if (newAppLocale == appLocale) return;
    switch (newAppLocale) {
      case AppLocale.English:
        currentLocale = supportedLocales[0];
        break;
      case AppLocale.Vietnamese:
        currentLocale = supportedLocales[1];
    }
    appLocale = newAppLocale;
    notifyListeners();
  }
}
