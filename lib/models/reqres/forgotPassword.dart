import 'package:demo_b/models/reqres/base.dart';

class ForgotPasswordReq extends BaseReq {
  String email;

  ForgotPasswordReq({this.email});
}

class ForgotPasswordRes extends BaseRes {
  ForgotPasswordRes({int status, String message})
      : super(status: status, message: message);
}
