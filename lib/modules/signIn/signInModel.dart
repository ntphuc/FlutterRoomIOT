import 'package:demo_b/constants/constant.dart';
import 'package:demo_b/constants/key_prefs.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/models/reqres/signIn.dart';
import 'package:demo_b/models/user.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/services/authService.dart';
import 'package:demo_b/utils/asyncStorage.dart';
import 'package:demo_b/utils/toast.dart';
import 'package:flutter/material.dart';

class SignInModel extends BaseModel {
  final AuthService _authService = AuthService.instance();
  BuildContext context;

  // String email = 'admin@gmail.com';
  // String password = 'admin@admin';
  String email = '';
  String password = '';

  SignInModel(this.context);

  Future<void> signIn() async {
    setLoading(true);
    try {
      SignInRes res = await _authService
          .signIn(SignInReq(email: email, password: password));
      if (res.status == 200) {
        Toast.success(message: Constant.success);
        await AsyncStorage.set(KeyPrefs.ACCESS_TOKEN, res.message);
        await AsyncStorage.set(KeyPrefs.USER_PROFILE, userToJson(res.data));
        Navigator.of(context).pushReplacementNamed(RouteName.home);
      } else {
        Toast.error(message: Constant.failure ?? '');
      }
    } catch (e) {
      print(e.toString());
      Toast.error(message: e?.toString());
    } finally {
      setLoading(false);
    }
  }
}
