// To parse this JSON data, do
//
//     final listDataResponse = listDataResponseFromJson(jsonString);

import 'dart:convert';

List<ListDataResponse> listDataResponseFromJson(String str) => List<ListDataResponse>.from(json.decode(str).map((x) => ListDataResponse.fromJson(x)));

String listDataResponseToJson(List<ListDataResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListDataResponse {
  String? orderNo;
  String? orderStatus;
  String? name;
  String? contactNo;
  String? addressNo;
  String? noOfCloths;
  String? payment;
  String? time;

  ListDataResponse({
    this.orderNo,
    this.orderStatus,
    this.name,
    this.contactNo,
    this.addressNo,
    this.noOfCloths,
    this.payment,
    this.time,
  });

  factory ListDataResponse.fromJson(Map<String, dynamic> json) => ListDataResponse(
    orderNo: json["orderNo"],
    orderStatus: json["orderStatus"],
    name: json["name"],
    contactNo: json["ContactNo"],
    addressNo: json["addressNo"],
    noOfCloths: json["noOfCloths"],
    payment: json["payment"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "orderNo": orderNo,
    "orderStatus": orderStatus,
    "name": name,
    "ContactNo": contactNo,
    "addressNo": addressNo,
    "noOfCloths": noOfCloths,
    "payment": payment,
    "time": time,
  };
}
