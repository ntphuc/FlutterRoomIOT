import 'dart:convert';

class UserApi {
  UserApi({
    this.data,
    this.metaData,
  });

  List<UserModel> data;
  MetaData metaData;

  UserApi copyWith({
    List<UserModel> data,
    MetaData metaData,
  }) =>
      UserApi(
        data: data ?? this.data,
        metaData: metaData ?? this.metaData,
      );

  factory UserApi.fromRawJson(String str) => UserApi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserApi.fromJson(Map<String, dynamic> json) => UserApi(
        data: json["data"] == null
            ? null
            : List<UserModel>.from(json["data"].map((x) => UserModel.fromJson(x))),
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

class UserModel {
  UserModel({
    this.roles,
    this.admin,
    this.groupUsers,
    this.createdTime,
    this.id,
    this.fullname,
    this.email,
    this.phoneNumber,
    this.gender,
    this.address,
    this.v,
  });

  List<dynamic> roles;
  bool admin;
  List<dynamic> groupUsers;
  int createdTime;
  String id;
  String fullname;
  String email;
  String phoneNumber;
  String gender;
  String address;
  int v;

  UserModel copyWith({
    List<dynamic> roles,
    bool admin,
    List<dynamic> groupUsers,
    int createdTime,
    String id,
    String fullname,
    String email,
    String phoneNumber,
    String gender,
    String address,
    int v,
  }) =>
      UserModel(
        roles: roles ?? this.roles,
        admin: admin ?? this.admin,
        groupUsers: groupUsers ?? this.groupUsers,
        createdTime: createdTime ?? this.createdTime,
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        v: v ?? this.v,
      );

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        roles: json["roles"] == null
            ? null
            : List<dynamic>.from(json["roles"].map((x) => x)),
        admin: json["admin"] == null ? null : json["admin"],
        groupUsers: json["group_users"] == null
            ? null
            : List<dynamic>.from(json["group_users"].map((x) => x)),
        createdTime: json["created_time"] == null ? null : json["created_time"],
        id: json["_id"] == null ? null : json["_id"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        gender: json["gender"] == null ? null : json["gender"],
        address: json["address"] == null ? null : json["address"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "roles": roles == null ? null : List<dynamic>.from(roles.map((x) => x)),
        "admin": admin == null ? null : admin,
        "group_users": groupUsers == null
            ? null
            : List<dynamic>.from(groupUsers.map((x) => x)),
        "created_time": createdTime == null ? null : createdTime,
        "_id": id == null ? null : id,
        "fullname": fullname == null ? null : fullname,
        "email": email == null ? null : email,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "gender": gender == null ? null : gender,
        "address": address == null ? null : address,
        "__v": v == null ? null : v,
      };
}

class MetaData {
  MetaData({
    this.totalRecords,
    this.limit,
    this.page,
    this.totalPage,
  });

  int totalRecords;
  String limit;
  String page;
  int totalPage;

  MetaData copyWith({
    int totalRecords,
    String limit,
    String page,
    int totalPage,
  }) =>
      MetaData(
        totalRecords: totalRecords ?? this.totalRecords,
        limit: limit ?? this.limit,
        page: page ?? this.page,
        totalPage: totalPage ?? this.totalPage,
      );

  factory MetaData.fromRawJson(String str) =>
      MetaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        totalRecords:
            json["total_records"] == null ? null : json["total_records"],
        limit: json["limit"] == null ? null : json["limit"],
        page: json["page"] == null ? null : json["page"],
        totalPage: json["total_page"] == null ? null : json["total_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_records": totalRecords == null ? null : totalRecords,
        "limit": limit == null ? null : limit,
        "page": page == null ? null : page,
        "total_page": totalPage == null ? null : totalPage,
      };
}
