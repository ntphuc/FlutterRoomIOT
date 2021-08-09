import 'dart:convert';

class NotificationApi {
  NotificationApi({
    this.data,
    this.metaData,
  });

  List<NotificationModel> data;
  MetaData metaData;

  NotificationApi copyWith({
    List<NotificationModel> data,
    MetaData metaData,
  }) =>
      NotificationApi(
        data: data ?? this.data,
        metaData: metaData ?? this.metaData,
      );

  factory NotificationApi.fromRawJson(String str) =>
      NotificationApi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationApi.fromJson(Map<String, dynamic> json) =>
      NotificationApi(
        data: json["data"] == null
            ? null
            : List<NotificationModel>.from(json["data"].map((x) => NotificationModel.fromJson(x))),
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

class NotificationModel {
  NotificationModel({
    this.createdTime,
    this.id,
    this.title,
    this.body,
    this.v,
  });

  int createdTime;
  String id;
  String title;
  String body;
  int v;

  NotificationModel copyWith({
    int createdTime,
    String id,
    String title,
    String body,
    int v,
  }) =>
      NotificationModel(
        createdTime: createdTime ?? this.createdTime,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        v: v ?? this.v,
      );

  factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        createdTime: json["created_time"] == null ? null : json["created_time"],
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "created_time": createdTime == null ? null : createdTime,
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "body": body == null ? null : body,
        "__v": v == null ? null : v,
      };
}

class MetaData {
  MetaData({
    this.totalRecords,
    this.page,
    this.limit,
    this.totalPages,
  });

  int totalRecords;
  String page;
  String limit;
  int totalPages;

  MetaData copyWith({
    int totalRecords,
    String page,
    String limit,
    int totalPages,
  }) =>
      MetaData(
        totalRecords: totalRecords ?? this.totalRecords,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalPages: totalPages ?? this.totalPages,
      );

  factory MetaData.fromRawJson(String str) =>
      MetaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        totalRecords:
            json["total_records"] == null ? null : json["total_records"],
        page: json["page"] == null ? null : json["page"],
        limit: json["limit"] == null ? null : json["limit"],
        totalPages: json["total_pages"] == null ? null : json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total_records": totalRecords == null ? null : totalRecords,
        "page": page == null ? null : page,
        "limit": limit == null ? null : limit,
        "total_pages": totalPages == null ? null : totalPages,
      };
}
