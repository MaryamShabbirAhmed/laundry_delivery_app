// To parse this JSON data, do
//
//     final getAllItemsResponse = getAllItemsResponseFromJson(jsonString);

import 'dart:convert';

GetAllItemsResponse getAllItemsResponseFromJson(String str) => GetAllItemsResponse.fromJson(json.decode(str));

String getAllItemsResponseToJson(GetAllItemsResponse data) => json.encode(data.toJson());

class GetAllItemsResponse {
  bool? error;
  int? errorCode;
  String? message;
  List<Datum>? data;

  GetAllItemsResponse({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  factory GetAllItemsResponse.fromJson(Map<String, dynamic> json) => GetAllItemsResponse(
    error: json["error"],
    errorCode: json["errorCode"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorCode": errorCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;
  String? icon;
  bool? isActive;
  String? categoryType;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Datum>? laundryItems;
  int? pricePerItem;
  int? quantity;
  int? laundryCategoryId;

  Datum({
    this.id,
    this.name,
    this.icon,
    this.isActive,
    this.categoryType,
    this.createdAt,
    this.updatedAt,
    this.laundryItems,
    this.pricePerItem,
    this.quantity,
    this.laundryCategoryId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    isActive: json["isActive"],
    categoryType: json["categoryType"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    laundryItems: json["laundry_items"] == null ? [] : List<Datum>.from(json["laundry_items"]!.map((x) => Datum.fromJson(x))),
    pricePerItem: json["pricePerItem"],
    quantity: json["quantity"]??0,
    laundryCategoryId: json["laundryCategoryId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "isActive": isActive,
    "categoryType": categoryType,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "laundry_items": laundryItems == null ? [] : List<dynamic>.from(laundryItems!.map((x) => x.toJson())),
    "pricePerItem": pricePerItem,
    "quantity": quantity,
    "laundryCategoryId": laundryCategoryId,
  };
}
