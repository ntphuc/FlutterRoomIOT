import 'package:demo_b/models/reqres/base.dart';
import 'package:demo_b/models/user.dart';

class SignInReq extends BaseReq {
  String email;
  String password;

  SignInReq({this.email, this.password});
}

class SignInRes extends BaseRes {
  User data;

  SignInRes({this.data, int status, String message})
      : super(status: status, message: message);
}
