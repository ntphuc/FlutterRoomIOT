import 'dart:convert';

import 'meta_data.dart';
import 'room_model.dart';

class RoomApi {
  RoomApi({
    this.data,
    this.metaData,
  });

  List<RoomModel> data;
  MetaData metaData;

  RoomApi copyWith({
    List<RoomModel> data,
    MetaData metaData,
  }) =>
      RoomApi(
        data: data ?? this.data,
        metaData: metaData ?? this.metaData,
      );

  factory RoomApi.fromRawJson(String str) => RoomApi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomApi.fromJson(Map<String, dynamic> json) => RoomApi(
        data: json["data"] == null
            ? null
            : List<RoomModel>.from(json["data"].map((x) => RoomModel.fromJson(x))),
        metaData: json["meta_data"] == null
            ? null
            : MetaData.fromJson(json["meta_data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "meta_data": metaData == null ? null : metaData.toJson(),
      };
}


