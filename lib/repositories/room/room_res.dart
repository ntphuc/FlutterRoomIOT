import 'package:demo_b/models/room/room_model.dart';
import 'package:dio/dio.dart';

import '../../configs/endpoint.dart';
import '../../models/room/room_api.dart';
import '../res_util.dart';

class RoomRes {
  final _dio = Dio();
  Future<RoomApi> getAllRoom() async {
    final header = ResUtil.getHeader();
    final res =
        await _dio.get(Endpoint.ROOM, options: Options(headers: header));
    if (res.statusCode == 200) {
      return RoomApi.fromJson(res.data);
    }
    return null;
  }
  Future<RoomModel> getRoomDetail(String roomId) async {
    final header = ResUtil.getHeader();
    final res =
        await _dio.get(Endpoint.getRoomDetail(roomId), options: Options(headers: header));
    if (res.statusCode == 200) {
      return RoomModel.fromJson(res.data);
    }
    return null;
  }
}
