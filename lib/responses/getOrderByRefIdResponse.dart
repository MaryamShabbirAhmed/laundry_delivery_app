// To parse this JSON data, do
//
//     final getOrderByRefIdResponse = getOrderByRefIdResponseFromJson(jsonString);

import 'dart:convert';

GetOrderByRefIdResponse getOrderByRefIdResponseFromJson(String str) => GetOrderByRefIdResponse.fromJson(json.decode(str));

String getOrderByRefIdResponseToJson(GetOrderByRefIdResponse data) => json.encode(data.toJson());

class GetOrderByRefIdResponse {
  bool? error;
  int? errorCode;
  String? message;
  List<OrderData>? data;

  GetOrderByRefIdResponse({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  factory GetOrderByRefIdResponse.fromJson(Map<String, dynamic> json) => GetOrderByRefIdResponse(
    error: json["error"],
    errorCode: json["errorCode"],
    message: json["message"],
    // data: json["data"] == null ? null : OrderData.fromJson(json["data"]),
    data: json["data"] == null ? [] : List<OrderData>.from(json["data"]!.map((x) => OrderData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorCode": errorCode,
    "message": message,
    // "data": data?.toJson(),
    "data": data == null ? [] : List<OrderData>.from(data!.map((x) => x.toJson())),

  };
}

class OrderData {
  int? id;
  DateTime? bookingDate;
  String? bookingTime;
  DateTime? deliveryDate;
  String? deliveryTime;
  String? pickUpLatLng;
  String? pickUpAddress;
  String? totalPrice;
  String? collectedPayment;
  String? paymentStatus;
  bool? isPaid;
  String? selectedPaymentType;
  String? status;
  String? referenceId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? createdBy;
  List<OrderDetail>? orderDetails;

  OrderData({
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
    this.orderDetails,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json["id"],
    bookingDate: json["bookingDate"] == null ? null : DateTime.parse(json["bookingDate"]),
    bookingTime: json["bookingTime"],
    deliveryDate: json["deliveryDate"] == null ? null : DateTime.parse(json["deliveryDate"]),
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
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookingDate": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
    "bookingTime": bookingTime,
    "deliveryDate": deliveryDate?.toIso8601String(),
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
    "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
  };
}

class OrderDetail {
  int? id;
  String? pricePerItem;
  String? quantity;
  String? itemName;
  String? subPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? orderId;
  int? laundryItemId;

  OrderDetail({
    this.id,
    this.pricePerItem,
    this.quantity,
    this.itemName,
    this.subPrice,
    this.createdAt,
    this.updatedAt,
    this.orderId,
    this.laundryItemId,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    pricePerItem: json["pricePerItem"],
    quantity: json["quantity"],
    itemName: json["itemName"],
    subPrice: json["subPrice"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    orderId: json["orderId"],
    laundryItemId: json["laundryItemId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pricePerItem": pricePerItem,
    "quantity": quantity,
    "itemName": itemName,
    "subPrice": subPrice,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "orderId": orderId,
    "laundryItemId": laundryItemId,
  };
}
