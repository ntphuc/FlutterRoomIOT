import 'package:demo_b/models/reqres/base.dart';

class SignOutReq extends BaseReq {}

class SignOutRes extends BaseRes {
  SignOutRes({int status, String message})
      : super(status: status, message: message);
}
