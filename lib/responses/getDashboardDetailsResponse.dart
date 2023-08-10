// To parse this JSON data, do
//
//     final getDashboardOrdersResponse = getDashboardOrdersResponseFromJson(jsonString);

import 'dart:convert';

GetDashboardOrdersResponse getDashboardOrdersResponseFromJson(String str) => GetDashboardOrdersResponse.fromJson(json.decode(str));

String getDashboardOrdersResponseToJson(GetDashboardOrdersResponse data) => json.encode(data.toJson());

class GetDashboardOrdersResponse {
  bool? error;
  int? errorCode;
  String? message;
  Data? data;

  GetDashboardOrdersResponse({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  factory GetDashboardOrdersResponse.fromJson(Map<String, dynamic> json) => GetDashboardOrdersResponse(
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
  int? pendingOrders;
  int? oldOrders;
  int? deliveredOrders;
  int? totalOrders;
  List<Order>? orders;

  Data({
    this.pendingOrders,
    this.oldOrders,
    this.deliveredOrders,
    this.totalOrders,
    this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pendingOrders: json["pendingOrders"],
    oldOrders: json["oldOrders"],
    deliveredOrders: json["deliveredOrders"],
    totalOrders: json["totalOrders"],
    orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pendingOrders": pendingOrders,
    "oldOrders": oldOrders,
    "deliveredOrders": deliveredOrders,
    "totalOrders": totalOrders,
    "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  int? id;
  String? bookingDate;
  String? bookingTime;
  String? deliveryDate;
  String? deliveryTime;
  String? pickUpLatLng;
  String? pickUpAddress;
  String? totalPrice;
  String? paymentStatus;
  bool? isPaid;
  String? selectedPaymentType;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? createdBy;

  Order({
    this.id,
    this.bookingDate,
    this.bookingTime,
    this.deliveryDate,
    this.deliveryTime,
    this.pickUpLatLng,
    this.pickUpAddress,
    this.totalPrice,
    this.paymentStatus,
    this.isPaid,
    this.selectedPaymentType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.createdBy,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    bookingDate: json["bookingDate"],
    bookingTime: json["bookingTime"],
    deliveryDate: json["deliveryDate"],
    deliveryTime: json["deliveryTime"],
    pickUpLatLng: json["pickUpLatLng"],
    pickUpAddress: json["pickUpAddress"],
    totalPrice: json["totalPrice"],
    paymentStatus: json["paymentStatus"],
    isPaid: json["isPaid"],
    selectedPaymentType: json["selectedPaymentType"],
    status: json["status"],
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
    "paymentStatus": paymentStatus,
    "isPaid": isPaid,
    "selectedPaymentType": selectedPaymentType,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userId": userId,
    "createdBy": createdBy,
  };
}
