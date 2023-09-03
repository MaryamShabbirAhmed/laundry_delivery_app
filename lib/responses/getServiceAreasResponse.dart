// To parse this JSON data, do
//
//     final getServiceAreasResponse = getServiceAreasResponseFromJson(jsonString);

import 'dart:convert';

GetServiceAreasResponse getServiceAreasResponseFromJson(String str) => GetServiceAreasResponse.fromJson(json.decode(str));

String getServiceAreasResponseToJson(GetServiceAreasResponse data) => json.encode(data.toJson());

class GetServiceAreasResponse {
  bool? error;
  int? errorCode;
  String? message;
  List<ServiceAreasDetail>? data;

  GetServiceAreasResponse({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  factory GetServiceAreasResponse.fromJson(Map<String, dynamic> json) => GetServiceAreasResponse(
    error: json["error"],
    errorCode: json["errorCode"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ServiceAreasDetail>.from(json["data"]!.map((x) => ServiceAreasDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorCode": errorCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ServiceAreasDetail {
  int? id;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;

  ServiceAreasDetail({
    this.id,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceAreasDetail.fromJson(Map<String, dynamic> json) => ServiceAreasDetail(
    id: json["id"],
    address: json["address"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
