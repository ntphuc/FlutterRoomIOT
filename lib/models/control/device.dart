// To parse this JSON data, do
//
//     final device = deviceFromJson(jsonString);

import 'dart:convert';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device {
  Device({
    this.isOn,
    this.createdTime,
    this.updatedTime,
    this.id,
    this.deviceName,
    this.note,
    this.userCreated,
    this.userUpdated,
    this.v,
    this.deviceType,
    this.maxValue,
    this.currentValue,
    this.minValue,
  });

  bool isOn;
  int createdTime;
  int updatedTime;
  String id;
  String deviceName;
  String note;
  String userCreated;
  String userUpdated;
  int v;
  int deviceType;
  int maxValue;
  int currentValue;
  int minValue;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        isOn: json["is_on"] == null ? null : json["is_on"],
        createdTime: json["created_time"] == null ? null : json["created_time"],
        updatedTime: json["updated_time"] == null ? null : json["updated_time"],
        id: json["_id"] == null ? null : json["_id"],
        deviceName: json["device_name"] == null ? null : json["device_name"],
        note: json["note"] == null ? null : json["note"],
        userCreated: json["user_created"] == null ? null : json["user_created"],
        userUpdated: json["user_updated"] == null ? null : json["user_updated"],
        v: json["__v"] == null ? null : json["__v"],
        deviceType: json["device_type"] == null ? null : json["device_type"],
        maxValue: json["max_value"] == null ? null : json["max_value"],
        currentValue:
            json["current_value"] == null ? null : json["current_value"],
        minValue: json["min_value"] == null ? null : json["min_value"],
      );

  Map<String, dynamic> toJson() => {
        "is_on": isOn == null ? null : isOn,
        "created_time": createdTime == null ? null : createdTime,
        "updated_time": updatedTime == null ? null : updatedTime,
        "_id": id == null ? null : id,
        "device_name": deviceName == null ? null : deviceName,
        "note": note == null ? null : note,
        "user_created": userCreated == null ? null : userCreated,
        "user_updated": userUpdated == null ? null : userUpdated,
        "__v": v == null ? null : v,
        "device_type": deviceType == null ? null : deviceType,
        "max_value": maxValue == null ? null : maxValue,
        "current_value": currentValue == null ? null : currentValue,
        "min_value": minValue == null ? null : minValue,
      };
}
