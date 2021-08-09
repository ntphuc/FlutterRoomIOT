import 'package:demo_b/constants/key_prefs.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/utils/asyncStorage.dart';
import 'package:flutter/cupertino.dart';

class SplashModel extends BaseModel {
  BuildContext context;

  SplashModel(this.context);

  Future<void> init() async {
    String token = await AsyncStorage.get(KeyPrefs.ACCESS_TOKEN);
    if (token == null || token.isEmpty) {
      Navigator.of(context).pushReplacementNamed(RouteName.signIn);
    } else {
      Navigator.of(context).pushReplacementNamed(RouteName.home);
    }
  }
}
