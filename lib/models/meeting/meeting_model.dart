import 'dart:convert';

import 'package:demo_b/models/room/room_model.dart';

class MeetingModel {
  MeetingModel({
    this.documents,
    this.members,
    this.remind,
    this.createdTime,
    this.updatedTime,
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.description,
    this.numberOfMembers,
    this.room,
    this.repeat,
    this.untilDate,
    this.dayOfWeek,
    this.userBooked,
    this.v,
    this.note,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
        documents: json["documents"] == null
            ? null
            : List<dynamic>.from(json["documents"].map((x) => x)),
        members: json["members"] == null
            ? null
            : List<String>.from(json["members"].map((x) => x)),
        remind: json["remind"] == null ? null : json["remind"],
        createdTime: json["created_time"] == null ? null : json["created_time"],
        updatedTime: json["updated_time"] == null ? null : json["updated_time"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        description: json["description"] == null ? null : json["description"],
        numberOfMembers: json["number_of_members"] == null
            ? null
            : json["number_of_members"],
        room: json["room"] == null
            ? null
            : json["room"] is String
                ? json['room']
                : RoomModel.fromJson(json['room']),
        repeat: json["repeat"] == null ? null : json["repeat"],
        note: json["note"] == null ? null : json["note"],
        untilDate: json["until_date"] == null ? null : json["until_date"],
        dayOfWeek: json["day_of_week"] == null ? null : json["day_of_week"],
        userBooked: json["user_booked"] == null ? null : json["user_booked"],
        v: json["__v"] == null ? null : json["__v"],
      );

  factory MeetingModel.fromRawJson(String str) =>
      MeetingModel.fromJson(json.decode(str));

  int createdTime;
  int dayOfWeek;
  String description;
  List<dynamic> documents;
  int endTime;
  String id;
  List<String> members;
  String name;
  String note;
  int numberOfMembers;
  bool remind;
  int repeat;
  dynamic room;
  int startTime;
  int untilDate;
  int updatedTime;
  String userBooked;
  int v;

  MeetingModel copyWith({
    List<dynamic> documents,
    List<String> members,
    bool remind,
    int createdTime,
    int updatedTime,
    String id,
    String name,
    int startTime,
    int endTime,
    String description,
    int numberOfMembers,
    dynamic room,
    int repeat,
    int untilDate,
    int dayOfWeek,
    String userBooked,
    int v,
    String note,
  }) =>
      MeetingModel(
        documents: documents ?? this.documents,
        members: members ?? this.members,
        remind: remind ?? this.remind,
        createdTime: createdTime ?? this.createdTime,
        updatedTime: updatedTime ?? this.updatedTime,
        id: id ?? this.id,
        name: name ?? this.name,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        description: description ?? this.description,
        numberOfMembers: numberOfMembers ?? this.numberOfMembers,
        room: room ?? this.room,
        repeat: repeat ?? this.repeat,
        untilDate: untilDate ?? this.untilDate,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        userBooked: userBooked ?? this.userBooked,
        v: v ?? this.v,
        note: note ?? this.note,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "documents": documents == null
            ? null
            : List<dynamic>.from(documents.map((x) => x)),
        "members":
            members == null ? null : List<String>.from(members.map((x) => x)),
        "remind": remind == null ? null : remind,
        "created_time": createdTime == null ? null : createdTime,
        "updated_time": updatedTime == null ? null : updatedTime,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "description": description == null ? null : description,
        "number_of_members": numberOfMembers == null ? null : numberOfMembers,
        "room": room == null
            ? null
            : room is String
                ? room
                : room.toJson(),
        "repeat": repeat == null ? null : repeat,
        "note": note == null ? null : note,
        "until_date": untilDate == null ? null : untilDate,
        "day_of_week": dayOfWeek == null ? null : dayOfWeek,
        "user_booked": userBooked == null ? null : userBooked,
        "__v": v == null ? null : v,
      };
}
