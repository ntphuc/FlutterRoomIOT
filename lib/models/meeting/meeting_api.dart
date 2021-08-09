import 'dart:convert';

import '../room/room_model.dart';
import 'meeting_model.dart';

class MeetingApi {
  MeetingApi({
    this.room,
    this.meetings,
  });

  factory MeetingApi.fromJson(Map<String, dynamic> json) => MeetingApi(
        room: json["room"] == null ? null : RoomModel.fromJson(json["room"]),
        meetings: json["meetings"] == null
            ? null
            : List<MeetingModel>.from(
                json["meetings"].map((x) => MeetingModel.fromJson(x))),
      );

  factory MeetingApi.fromRawJson(String str) =>
      MeetingApi.fromJson(json.decode(str));

  List<MeetingModel> meetings;
  RoomModel room;

  MeetingApi copyWith({
    RoomModel room,
    List<MeetingModel> meetings,
  }) =>
      MeetingApi(
        room: room ?? this.room,
        meetings: meetings ?? this.meetings,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "room": room == null ? null : room.toJson(),
        "meetings": meetings == null
            ? null
            : List<dynamic>.from(meetings.map((x) => x.toJson())),
      };
}


