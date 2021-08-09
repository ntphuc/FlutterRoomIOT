import 'package:validators/validators.dart';

import '../../modules/base/baseModel.dart';

class ValidationItem {
  ValidationItem({this.value, this.error});

  final String value;
  final String error;
}

class ValidationModel extends BaseModel {
  ValidationItem _email = ValidationItem();
  ValidationItem _password = ValidationItem();

  ValidationItem get email => _email;

  ValidationItem get password => _password;

  void onEmailChanged(String value) {
    _email = ValidationItem(value: value);
  }

  void onPasswordChanged(String value) {
    _password = ValidationItem(value: value);
  }

  void validatePassword(String password) {
    if (isNull(password) || password.isEmpty) {
      _password = ValidationItem(
          value: _password.value, error: 'Mật khẩu không được trống ');
    } else if (password.length < 6) {
      _password = ValidationItem(
          value: _password.value, error: 'Mật khẩu phải chứa ít nhất 6 kí tự');
    }
    notifyListeners();
  }

  void validateEmail(String email) {
    if (isNull(email) || email.isEmpty) {
      _email =
          ValidationItem(value: _email.value, error: 'Email không được trống');
    } else if (!isEmail(email)) {
      _email = ValidationItem(value: _email.value, error: 'Email không hợp lệ');
    }
    notifyListeners();
  }

  bool isValidSignIn(String email, String password) {
    validateEmail(email);
    validatePassword(password);
    if (isNull(_email.error) && isNull(_password.error)) {
      return true;
    }
    return false;
  }

  bool isValidForgotPassword(String email) {
    validateEmail(email);
    if (isNull(_email.error)) {
      return true;
    }
    return false;
  }
}
