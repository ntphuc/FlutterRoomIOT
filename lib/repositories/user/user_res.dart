import 'package:dio/dio.dart';

import '../../configs/endpoint.dart';
import '../../models/user/user_model.dart';
import '../res_util.dart';

class UserRes {
  final _dio = Dio();
  Future<UserApi> getAllUser() async {
    final header = ResUtil.getHeader();
    final res = await _dio.get(
      Endpoint.getAllUser,
      options: Options(headers: header),
    );
    if (res.statusCode == 200) {
      return UserApi.fromJson(res.data);
    }
    return null;
  }

  Future<UserModel> getUserById(String userId) async {
    final header = ResUtil.getHeader();
    final res = await _dio.get(
      Endpoint.getUserById(userId),
      options: Options(headers: header),
    );
    if (res.statusCode == 200) {
      return UserModel.fromJson(res.data);
    }
    return null;
  }
}
