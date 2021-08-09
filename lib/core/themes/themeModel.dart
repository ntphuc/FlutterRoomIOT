import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppTheme { Light, Dark }

class ThemeModel extends ChangeNotifier {
  AppTheme appTheme = AppTheme.Light;
  ThemeData currentTheme = ThemeData.light();

  void toggleTheme(AppTheme newAppTheme) {
    if (newAppTheme == appTheme) return;
    switch (newAppTheme) {
      case AppTheme.Light:
        currentTheme = ThemeData.light();
        break;
      case AppTheme.Dark:
        currentTheme = ThemeData.dark();
        break;
    }
    appTheme = newAppTheme;
    notifyListeners();
  }
}
