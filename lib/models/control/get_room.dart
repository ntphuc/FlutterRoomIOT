import 'dart:convert';

import 'package:demo_b/models/control/pagination.dart';
import 'package:demo_b/models/control/room.dart';

GetRoomRes getRoomResFromJson(String str) =>
    GetRoomRes.fromJson(json.decode(str));

String getRoomResToJson(GetRoomRes data) => json.encode(data.toJson());

class GetRoomRes {
  GetRoomRes({
    this.data,
    this.metaData,
  });

  List<Room> data;
  Pagination metaData;

  factory GetRoomRes.fromJson(Map<String, dynamic> json) => GetRoomRes(
        data: json["data"] == null
            ? null
            : List<Room>.from(json["data"].map((x) => Room.fromJson(x))),
        metaData: json["meta_data"] == null
            ? null
            : Pagination.fromJson(json["meta_data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "meta_data": metaData == null ? null : metaData.toJson(),
      };
}
