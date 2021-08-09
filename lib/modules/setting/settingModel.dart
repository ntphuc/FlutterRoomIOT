import 'package:demo_b/constants/key_prefs.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/models/user.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/utils/asyncStorage.dart';
import 'package:flutter/cupertino.dart';

class SettingModel extends BaseModel {
  BuildContext context;
  User currentUser;

  SettingModel(this.context);

  Future<void> init() async {
    String strUser = await AsyncStorage.get(KeyPrefs.USER_PROFILE);
    currentUser = userFromJson(strUser);
    notifyListeners();
  }

  Future<void> signOut() async {
    await AsyncStorage.remove(KeyPrefs.ACCESS_TOKEN);
    await AsyncStorage.remove(KeyPrefs.USER_PROFILE);
    Navigator.of(context).pushReplacementNamed(RouteName.signIn);
  }
}
