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
  int? deliveredOrders;
  int? totalOrders;
  int? nextPage;
  int? currentPage;
  int? totalPages;
  Orders? orders;

  Data({
    this.pendingOrders,
    this.deliveredOrders,
    this.totalOrders,
    this.nextPage,
    this.currentPage,
    this.totalPages,
    this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pendingOrders: json["pendingOrders"],
    deliveredOrders: json["deliveredOrders"],
    totalOrders: json["totalOrders"],
    nextPage: json["nextPage"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
  );

  Map<String, dynamic> toJson() => {
    "pendingOrders": pendingOrders,
    "deliveredOrders": deliveredOrders,
    "totalOrders": totalOrders,
    "nextPage": nextPage,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "orders": orders?.toJson(),
  };
}

class Orders {
  int? count;
  List<Row>? rows;

  Orders({
    this.count,
    this.rows,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    count: json["count"],
    rows: json["rows"] == null ? [] : List<Row>.from(json["rows"]!.map((x) => Row.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "rows": rows == null ? [] : List<dynamic>.from(rows!.map((x) => x.toJson())),
  };
}

class Row {
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? createdBy;
  User? orderedUser;
  User? createdByUser;
  List<OrderDetail>? orderDetails;

  Row({
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
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.createdBy,
    this.orderedUser,
    this.createdByUser,
    this.orderDetails,
  });

  factory Row.fromJson(Map<String, dynamic> json) => Row(
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
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"],
    createdBy: json["createdBy"],
    orderedUser: json["orderedUser"] == null ? null : User.fromJson(json["orderedUser"]),
    createdByUser: json["createdByUser"] == null ? null : User.fromJson(json["createdByUser"]),
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookingDate": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
    "bookingTime": bookingTime,
    "deliveryDate": "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
    "deliveryTime": deliveryTime,
    "pickUpLatLng": pickUpLatLng,
    "pickUpAddress": pickUpAddress,
    "totalPrice": totalPrice,
    "collectedPayment": collectedPayment,
    "paymentStatus": paymentStatus,
    "isPaid": isPaid,
    "selectedPaymentType": selectedPaymentType,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userId": userId,
    "createdBy": createdBy,
    "orderedUser": orderedUser?.toJson(),
    "createdByUser": createdByUser?.toJson(),
    "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
  };
}

class User {
  int? id;
  String? name;
  String? mobileNumber;
  String? address;
  String? loginId;
  String? password;
  dynamic profileImage;
  bool? isActive;
  String? userType;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic serviceAreaId;

  User({
    this.id,
    this.name,
    this.mobileNumber,
    this.address,
    this.loginId,
    this.password,
    this.profileImage,
    this.isActive,
    this.userType,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.serviceAreaId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    mobileNumber: json["mobileNumber"],
    address: json["address"],
    loginId: json["loginId"],
    password: json["password"],
    profileImage: json["profileImage"],
    isActive: json["isActive"],
    userType: json["userType"],
    deletedAt: json["deletedAt"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    serviceAreaId: json["serviceAreaId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobileNumber": mobileNumber,
    "address": address,
    "loginId": loginId,
    "password": password,
    "profileImage": profileImage,
    "isActive": isActive,
    "userType": userType,
    "deletedAt": deletedAt,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "serviceAreaId": serviceAreaId,
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
