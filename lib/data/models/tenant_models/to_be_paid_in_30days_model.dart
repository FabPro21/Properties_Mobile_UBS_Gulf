// To parse this JSON data, do
//
//     final toBePaidIn30DaysModel = toBePaidIn30DaysModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ToBePaidIn30DaysModel toBePaidIn30DaysModelFromJson(String str) =>
    ToBePaidIn30DaysModel.fromJson(json.decode(str));

String toBePaidIn30DaysModelToJson(ToBePaidIn30DaysModel data) =>
    json.encode(data.toJson());

class ToBePaidIn30DaysModel {
  ToBePaidIn30DaysModel({
    this.data,
    this.statusCode,
    this.message,
    this.status,
    this.totalAmount,
  });

  List<Datum> data;
  String statusCode;
  String message;
  String status;
  dynamic totalAmount;

  factory ToBePaidIn30DaysModel.fromJson(Map<String, dynamic> json) {
    var amount;
    try {
      var am = json["totalAmount"];
      final paidFormatter = NumberFormat('#,##0.00', 'AR');
      amount = paidFormatter.format(am);
    } catch (e) {
      print(e);
    }
    return ToBePaidIn30DaysModel(
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      statusCode: json["statusCode"],
      message: json["message"],
      status: json["status"],
      totalAmount: amount,
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "statusCode": statusCode,
        "message": message,
        "status": status,
        "totalAmount": totalAmount,
      };
}

class Datum {
  Datum({
    this.contractId,
    this.amount,
    this.transactionDate,
    this.transactionType,
    this.transactionNo,
  });

  String contractId;
  dynamic amount;
  String transactionDate;
  String transactionType;
  String transactionNo;

  factory Datum.fromJson(Map<String, dynamic> json) {
    var amount;
    try {
      var am = json["amount"];
      final paidFormatter = NumberFormat('#,##0.00', 'AR');
      amount = paidFormatter.format(am);
    } catch (e) {
      print(e);
    }
    return Datum(
      contractId: json["contractID"],
      amount: amount,
      transactionDate: json["transactionDate"],
      transactionType: json["transactionType"],
      transactionNo: json["transactionNo"],
    );
  }

  Map<String, dynamic> toJson() => {
        "contractID": contractId,
        "amount": amount,
        "transactionDate": transactionDate,
        "transactionType": transactionType,
        "transactionNo": transactionNo,
      };
}
