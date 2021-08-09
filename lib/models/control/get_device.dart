// To parse this JSON data, do
//
//     final getDeviceRes = getDeviceResFromJson(jsonString);

import 'dart:convert';

import 'package:demo_b/models/control/device.dart';
import 'package:demo_b/models/control/pagination.dart';

GetDeviceRes getDeviceResFromJson(String str) =>
    GetDeviceRes.fromJson(json.decode(str));

String getDeviceResToJson(GetDeviceRes data) => json.encode(data.toJson());

class GetDeviceRes {
  GetDeviceRes({
    this.data,
    this.metaData,
  });

  List<Device> data;
  Pagination metaData;

  factory GetDeviceRes.fromJson(Map<String, dynamic> json) => GetDeviceRes(
        data: json["data"] == null
            ? null
            : List<Device>.from(json["data"].map((x) => Device.fromJson(x))),
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
