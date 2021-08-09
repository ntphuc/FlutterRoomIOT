import 'dart:io';

import 'package:demo_b/services/io.dart';
import 'package:demo_b/services/share_pref_name.dart';

class ResUtil {
  static Map<String, dynamic> getHeader() {
    final token = IO.getString(SharedPrefsName.token, defValue: '');
    if (token == '') {
      return {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    } else {
      return {
        'x-auth-token': token,
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    }
  }
}
