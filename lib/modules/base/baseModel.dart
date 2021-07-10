import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  bool loading = false;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
