// To parse this JSON data, do
//
//     final boodOrderResponse = boodOrderResponseFromJson(jsonString);

import 'dart:convert';

BoodOrderResponse boodOrderResponseFromJson(String str) => BoodOrderResponse.fromJson(json.decode(str));

String boodOrderResponseToJson(BoodOrderResponse data) => json.encode(data.toJson());

class BoodOrderResponse {
  bool? error;
  int? errorCode;
  String? message;
  Data? data;

  BoodOrderResponse({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  factory BoodOrderResponse.fromJson(Map<String, dynamic> json) => BoodOrderResponse(
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
  Order? order;
  Body? body;
  List<OrderDetail>? orderDetails;

  Data({
    this.order,
    this.body,
    this.orderDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    body: json["body"] == null ? null : Body.fromJson(json["body"]),
    orderDetails: json["orderDetails"] == null ? [] : List<OrderDetail>.from(json["orderDetails"]!.map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "body": body?.toJson(),
    "orderDetails": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
  };
}

class Body {
  String? bookingDate;
  String? bookingTime;
  String? deliveryDate;
  String? deliveryTime;
  String? pickUpLatLng;
  String? pickUpAddress;
  String? userId;
  int? totalPrice;
  String? createdBy;
  List<Item>? items;

  Body({
    this.bookingDate,
    this.bookingTime,
    this.deliveryDate,
    this.deliveryTime,
    this.pickUpLatLng,
    this.pickUpAddress,
    this.userId,
    this.totalPrice,
    this.createdBy,
    this.items,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    bookingDate: json["bookingDate"],
    bookingTime: json["bookingTime"],
    deliveryDate: json["deliveryDate"],
    deliveryTime: json["deliveryTime"],
    pickUpLatLng: json["pickUpLatLng"],
    pickUpAddress: json["pickUpAddress"],
    userId: json["userId"],
    totalPrice: json["totalPrice"],
    createdBy: json["createdBy"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bookingDate": bookingDate,
    "bookingTime": bookingTime,
    "deliveryDate": deliveryDate,
    "deliveryTime": deliveryTime,
    "pickUpLatLng": pickUpLatLng,
    "pickUpAddress": pickUpAddress,
    "userId": userId,
    "totalPrice": totalPrice,
    "createdBy": createdBy,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  int? pricePerItem;
  String? itemName;
  int? laundryItemId;
  String? quantity;
  String? subPrice;
  int? orderId;

  Item({
    this.pricePerItem,
    this.itemName,
    this.laundryItemId,
    this.quantity,
    this.subPrice,
    this.orderId,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    pricePerItem: json["pricePerItem"],
    itemName: json["itemName"],
    laundryItemId: json["laundryItemId"],
    quantity: json["quantity"],
    subPrice: json["subPrice"],
    orderId: json["orderId"],
  );

  Map<String, dynamic> toJson() => {
    "pricePerItem": pricePerItem,
    "itemName": itemName,
    "laundryItemId": laundryItemId,
    "quantity": quantity,
    "subPrice": subPrice,
    "orderId": orderId,
  };
}

class Order {
  String? paymentStatus;
  bool? isPaid;
  String? selectedPaymentType;
  String? status;
  int? id;
  String? bookingDate;
  String? bookingTime;
  dynamic deliveryDate;
  String? deliveryTime;
  String? pickUpLatLng;
  String? pickUpAddress;
  String? userId;
  int? totalPrice;
  String? createdBy;
  DateTime? updatedAt;
  DateTime? createdAt;

  Order({
    this.paymentStatus,
    this.isPaid,
    this.selectedPaymentType,
    this.status,
    this.id,
    this.bookingDate,
    this.bookingTime,
    this.deliveryDate,
    this.deliveryTime,
    this.pickUpLatLng,
    this.pickUpAddress,
    this.userId,
    this.totalPrice,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    paymentStatus: json["paymentStatus"],
    isPaid: json["isPaid"],
    selectedPaymentType: json["selectedPaymentType"],
    status: json["status"],
    id: json["id"],
    bookingDate: json["bookingDate"],
    bookingTime: json["bookingTime"],
    deliveryDate: json["deliveryDate"],
    deliveryTime: json["deliveryTime"],
    pickUpLatLng: json["pickUpLatLng"],
    pickUpAddress: json["pickUpAddress"],
    userId: json["userId"],
    totalPrice: json["totalPrice"],
    createdBy: json["createdBy"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "paymentStatus": paymentStatus,
    "isPaid": isPaid,
    "selectedPaymentType": selectedPaymentType,
    "status": status,
    "id": id,
    "bookingDate": bookingDate,
    "bookingTime": bookingTime,
    "deliveryDate": deliveryDate,
    "deliveryTime": deliveryTime,
    "pickUpLatLng": pickUpLatLng,
    "pickUpAddress": pickUpAddress,
    "userId": userId,
    "totalPrice": totalPrice,
    "createdBy": createdBy,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}

class OrderDetail {
  int? id;
  int? pricePerItem;
  String? itemName;
  int? laundryItemId;
  String? quantity;
  String? subPrice;
  int? orderId;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderDetail({
    this.id,
    this.pricePerItem,
    this.itemName,
    this.laundryItemId,
    this.quantity,
    this.subPrice,
    this.orderId,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    pricePerItem: json["pricePerItem"],
    itemName: json["itemName"],
    laundryItemId: json["laundryItemId"],
    quantity: json["quantity"],
    subPrice: json["subPrice"],
    orderId: json["orderId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pricePerItem": pricePerItem,
    "itemName": itemName,
    "laundryItemId": laundryItemId,
    "quantity": quantity,
    "subPrice": subPrice,
    "orderId": orderId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
