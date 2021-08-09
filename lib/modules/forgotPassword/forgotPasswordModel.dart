import 'package:demo_b/constants/constant.dart';
import 'package:demo_b/models/reqres/forgotPassword.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/services/authService.dart';
import 'package:demo_b/utils/toast.dart';
import 'package:flutter/material.dart';

class ForgotPasswordModel extends BaseModel {
  final AuthService _authService = AuthService.instance();
  BuildContext context;
  String email;

  ForgotPasswordModel(this.context);

  Future<void> forgotPassword() async {
    setLoading(true);
    try {
      ForgotPasswordRes res =
          await _authService.forgotPassword(ForgotPasswordReq(email: email));
      if (res.status == 200) {
        Toast.success(message: Constant.success);
      } else {
        Toast.error(message: Constant.failure);
      }
    } catch (e) {
      print(e.toString());
      Toast.error(message: e.toString());
    } finally {
      setLoading(false);
    }
  }
}
