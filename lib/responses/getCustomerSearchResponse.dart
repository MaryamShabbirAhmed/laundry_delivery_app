// To parse this JSON data, do
//
//     final getCustomerSearchResponse = getCustomerSearchResponseFromJson(jsonString);

import 'dart:convert';

GetCustomerSearchResponse getCustomerSearchResponseFromJson(String str) => GetCustomerSearchResponse.fromJson(json.decode(str));

String getCustomerSearchResponseToJson(GetCustomerSearchResponse data) => json.encode(data.toJson());

class GetCustomerSearchResponse {
  List<SearchDetail>? data;

  GetCustomerSearchResponse({
    this.data,
  });

  factory GetCustomerSearchResponse.fromJson(Map<String, dynamic> json) => GetCustomerSearchResponse(
    data: json["data"] == null ? [] : List<SearchDetail>.from(json["data"]!.map((x) => SearchDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SearchDetail {
  int? id;
  String? name;
  String? mobileNumber;
  String? address;
  String? emiratesIdNo;
  String? dob;
  String? loginId;
  dynamic profileImage;
  bool? isActive;
  String? userType;
  DateTime? createdAt;
  DateTime? updatedAt;

  SearchDetail({
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

  factory SearchDetail.fromJson(Map<String, dynamic> json) => SearchDetail(
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
