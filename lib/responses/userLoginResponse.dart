// To parse this JSON data, do
//
//     final userLoginResponse = userLoginResponseFromJson(jsonString);

import 'dart:convert';

UserLoginResponse userLoginResponseFromJson(String str) => UserLoginResponse.fromJson(json.decode(str));

String userLoginResponseToJson(UserLoginResponse data) => json.encode(data.toJson());

class UserLoginResponse {
  bool? error;
  String? message;
  String? token;
  Data? data;

  UserLoginResponse({
    this.error,
    this.message,
    this.token,
    this.data,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) => UserLoginResponse(
    error: json["error"],
    message: json["message"],
    token: json["token"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "token": token,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? name;
  String? mobileNumber;
  String? address;
  dynamic emiratesIdNo;
  String? dob;
  String? loginId;
  dynamic profileImage;
  bool? isActive;
  String? userType;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.name,
    this.mobileNumber,
    this.address,
    this.emiratesIdNo,
    this.dob,
    this.loginId,
    this.profileImage,
    this.isActive,
    this.userType,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    mobileNumber: json["mobileNumber"],
    address: json["address"],
    emiratesIdNo: json["emiratesIdNo"],
    dob: json["dob"],
    loginId: json["loginId"],
    profileImage: json["profileImage"],
    isActive: json["isActive"],
    userType: json["userType"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobileNumber": mobileNumber,
    "address": address,
    "emiratesIdNo": emiratesIdNo,
    "dob": dob,
    "loginId": loginId,
    "profileImage": profileImage,
    "isActive": isActive,
    "userType": userType,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
