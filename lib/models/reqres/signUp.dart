import 'package:demo_b/models/reqres/base.dart';
import 'package:demo_b/models/token.dart';

class SignUpReq extends BaseReq {
  String email;
  String password;
  String firstName;
  String lastName;

  SignUpReq({this.email, this.password, this.firstName, this.lastName});
}

class SignUpRes extends BaseRes {
  Token data;

  SignUpRes({this.data, int status, String message})
      : super(status: status, message: message);
}
