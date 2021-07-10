import 'package:demo_b/constants/constant.dart';
import 'package:demo_b/models/reqres/signIn.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/services/authService.dart';
import 'package:demo_b/utils/toast.dart';

class SignInModel extends BaseModel {
  final AuthService _authService = AuthService.instance();
  String email;
  String password;

  Future<void> signIn(Function onSuccess) async {
    setLoading(true);
    try {
      SignInRes res = await _authService
          .signIn(SignInReq(email: email, password: password));
      if (res.status == 200) {
        Toast.success(message: Constant.success);
        onSuccess();
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
