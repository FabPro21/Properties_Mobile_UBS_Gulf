// To parse this JSON data, do
//
//     final onlinePaymentsModel = onlinePaymentsModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

OnlinePaymentsModel onlinePaymentsModelFromJson(String str) =>
    OnlinePaymentsModel.fromJson(json.decode(str));

String onlinePaymentsModelToJson(OnlinePaymentsModel data) =>
    json.encode(data.toJson());

class OnlinePaymentsModel {
  OnlinePaymentsModel({this.contractPayments, this.note});

  List<ContractPayment> contractPayments;
  String note;

  factory OnlinePaymentsModel.fromJson(Map<String, dynamic> json) =>
      OnlinePaymentsModel(
          contractPayments: List<ContractPayment>.from(
              json["contractPayments"].map((x) => ContractPayment.fromJson(x))),
          note: json["note"]);

  Map<String, dynamic> toJson() => {
        "contractPayments":
            List<dynamic>.from(contractPayments.map((x) => x.toJson())),
      };
}

class ContractPayment {
  ContractPayment({
    this.paymentDetailId,
    this.title,
    this.description,
    this.status,
    this.contractno,
    this.refNo,
    this.createdOn,
    this.amount,
  });

  int paymentDetailId;
  String title;
  String description;
  String status;
  String contractno;
  String refNo;
  String createdOn;
  String amount;

  factory ContractPayment.fromJson(Map<String, dynamic> json) {
    final amountFormat = NumberFormat('#,##0.00', 'AR');
    String amount = amountFormat.format(json["amount"] ?? 0);
    return ContractPayment(
      paymentDetailId: json["paymentDetailId"],
      title: json["title"],
      description: json["description"],
      status: json["status"],
      contractno: json["contractno"],
      refNo: json['referenceNo'],
      createdOn: json["createdOn"],
      amount: amount,
    );
  }

  Map<String, dynamic> toJson() => {
        "paymentDetailId": paymentDetailId,
        "title": title,
        "description": description,
        "status": status,
        "contractno": contractno,
        "createdOn": createdOn,
        "amount": amount,
      };
}
