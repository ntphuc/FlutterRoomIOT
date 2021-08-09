import 'dart:convert';
import 'dart:developer';

import 'package:demo_b/models/meeting/meeting_api.dart';
import 'package:demo_b/models/meeting/meeting_model.dart';
import 'package:dio/dio.dart';

import '../../configs/endpoint.dart';
import '../res_util.dart';

class MeetingRes {
  final _dio = Dio();

  /// Get all of the meetings
  Future<MeetingApi> getAllMeetings(
    String roomId,
    int startTime,
    int endTime,
  ) async {
    final header = ResUtil.getHeader();
    final res = await _dio.get(
      Endpoint.meetingRoom(roomId, startTime, endTime),
      options: Options(headers: header),
    );
    log(res?.data?.toString());
    if (res.statusCode == 200) {
      return MeetingApi.fromJson(res.data);
    }
    return null;
  }

  /// Get only my meetings
  Future<List<MeetingModel>> getMyMeetings() async {
    final header = ResUtil.getHeader();
    final res = await _dio.get(
      Endpoint.myMeeting,
      options: Options(headers: header),
    );
    log(res?.data?.toString());
    if (res.statusCode == 200) {
      return List<MeetingModel>.from(
        res.data.map(
          (x) => MeetingModel.fromJson(x),
        ),
      );
    }
    return null;
  }

  /// Get details of the meeeting
  Future<MeetingModel> getMeetingDetail(String id) async {
    final header = ResUtil.getHeader();
    final res = await _dio.get(
      Endpoint.meetingDetail(id),
      options: Options(headers: header),
    );
    log(res?.data?.toString());
    if (res.statusCode == 200) {
      return MeetingModel.fromJson(res.data);
    }
    return null;
  }

  ///Create a new meeting
  Future<bool> createNewMeeting(MeetingModel model) async {
    try {
      final header = ResUtil.getHeader();
      final jsonData = model.toJson();
      jsonData.removeWhere((key, value) => value == null);
      final res = await _dio.post(
        Endpoint.meeting,
        data: jsonEncode(jsonData),
        options: Options(headers: header),
      );
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  ///update the new meeting
  Future<bool> updateNewMeeting(MeetingModel model) async {
    try {
      final header = ResUtil.getHeader();
      final jsonData = model.toJson();
      jsonData.removeWhere((key, value) => value == null);
      jsonData.remove('updated_time');
      jsonData.remove('created_time');
      jsonData.remove('_id');
      jsonData.remove('user_booked');
      jsonData.remove('__v');
      final res = await _dio.put(
        Endpoint.updateMeeting(model.id),
        data: jsonEncode(jsonData),
        options: Options(headers: header),
      );
      log(res.data.toString());
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } catch (err) {
      log(err.toString());
      return false;
    }
  }
}
