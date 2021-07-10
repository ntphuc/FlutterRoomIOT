abstract class BaseReq {}

abstract class BaseRes {
  int status;
  String message;

  BaseRes({this.status, this.message});
}
