// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.email,
    this.admin,
    this.fullname,
    this.phoneNumber,
    this.address,
    this.gender,
  });

  String id;
  String email;
  bool admin;
  String fullname;
  String phoneNumber;
  String address;
  String gender;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        email: json["email"] == null ? null : json["email"],
        admin: json["admin"] == null ? null : json["admin"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        address: json["address"] == null ? null : json["address"],
        gender: json["gender"] == null ? null : json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "email": email == null ? null : email,
        "admin": admin == null ? null : admin,
        "fullname": fullname == null ? null : fullname,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "address": address == null ? null : address,
        "gender": gender == null ? null : gender,
      };
}
