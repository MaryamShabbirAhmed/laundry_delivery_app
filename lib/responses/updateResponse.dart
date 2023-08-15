// To parse this JSON data, do
//
//     final updateOrderResponse = updateOrderResponseFromJson(jsonString);

import 'dart:convert';

UpdateOrderResponse updateOrderResponseFromJson(String str) => UpdateOrderResponse.fromJson(json.decode(str));

String updateOrderResponseToJson(UpdateOrderResponse data) => json.encode(data.toJson());

class UpdateOrderResponse {
  bool? error;
  int? errorCode;
  String? message;
  Data? data;

  UpdateOrderResponse({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  factory UpdateOrderResponse.fromJson(Map<String, dynamic> json) => UpdateOrderResponse(
    error: json["error"],
    errorCode: json["errorCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorCode": errorCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  dynamic bookingDate;
  dynamic bookingTime;
  dynamic deliveryDate;
  dynamic deliveryTime;
  dynamic pickUpLatLng;
  dynamic pickUpAddress;
  dynamic totalPrice;
  dynamic collectedPayment;
  String? paymentStatus;
  bool? isPaid;
  String? selectedPaymentType;
  String? status;
  dynamic referenceId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? createdBy;

  Data({
    this.id,
    this.bookingDate,
    this.bookingTime,
    this.deliveryDate,
    this.deliveryTime,
    this.pickUpLatLng,
    this.pickUpAddress,
    this.totalPrice,
    this.collectedPayment,
    this.paymentStatus,
    this.isPaid,
    this.selectedPaymentType,
    this.status,
    this.referenceId,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.createdBy,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    bookingDate: json["bookingDate"],
    bookingTime: json["bookingTime"],
    deliveryDate: json["deliveryDate"],
    deliveryTime: json["deliveryTime"],
    pickUpLatLng: json["pickUpLatLng"],
    pickUpAddress: json["pickUpAddress"],
    totalPrice: json["totalPrice"],
    collectedPayment: json["collectedPayment"],
    paymentStatus: json["paymentStatus"],
    isPaid: json["isPaid"],
    selectedPaymentType: json["selectedPaymentType"],
    status: json["status"],
    referenceId: json["referenceId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookingDate": bookingDate,
    "bookingTime": bookingTime,
    "deliveryDate": deliveryDate,
    "deliveryTime": deliveryTime,
    "pickUpLatLng": pickUpLatLng,
    "pickUpAddress": pickUpAddress,
    "totalPrice": totalPrice,
    "collectedPayment": collectedPayment,
    "paymentStatus": paymentStatus,
    "isPaid": isPaid,
    "selectedPaymentType": selectedPaymentType,
    "status": status,
    "referenceId": referenceId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userId": userId,
    "createdBy": createdBy,
  };
}
