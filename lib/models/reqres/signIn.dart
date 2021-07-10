import 'package:demo_b/models/reqres/base.dart';
import 'package:demo_b/models/token.dart';

class SignInReq extends BaseReq {
  String email;
  String password;

  SignInReq({this.email, this.password});
}

class SignInRes extends BaseRes {
  Token data;

  SignInRes({this.data, int status, String message})
      : super(status: status, message: message);
}
