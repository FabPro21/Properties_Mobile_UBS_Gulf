// To parse this JSON data, do
//
//     final contractRenewalInfo = contractRenewalInfoFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ContractRenewalInfo contractRenewalInfoFromJson(String? str) =>
    ContractRenewalInfo.fromJson(json.decode(str!));

String? contractRenewalInfoToJson(ContractRenewalInfo data) =>
    json.encode(data.toJson());

class ContractRenewalInfo {
  ContractRenewalInfo({
    this.status,
    this.record,
    this.link,
  });

  String? status;
  Record? record;
  String? link;

  factory ContractRenewalInfo.fromJson(Map<String?, dynamic> json) =>
      ContractRenewalInfo(
        status: json["status"],
        record: Record.fromJson(json["record"]),
        link: json["link"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "record": record!.toJson(),
        "link": link,
      };
}

class Record {
  Record({
    this.contractId,
    this.installments,
    this.emirateId,
    this.totalAmount,
    this.amount,
    this.contractno,
    this.fromDate,
    this.endDate,
    this.addNewDate,
    this.endNewDate,
    this.emirateName,
  });

  int? contractId;
  int? installments;
  int? emirateId;
  double? totalAmount;
  String? amount;
  String? contractno;
  String? fromDate;
  String? endDate;
  String? addNewDate;
  String? endNewDate;
  String? emirateName;

  factory Record.fromJson(Map<String?, dynamic> json) {
    final amountFormat = NumberFormat('#,##0.00', 'AR');
    String? amount = amountFormat.format(json["amount"] ?? 0);
    return Record(
      contractId: json["contractID"],
      installments: json["installments"],
      emirateId: json["emirateID"],
      totalAmount: json["totalAmount"],
      amount: amount,
      contractno: json["contractno"],
      fromDate: json["fromDate"],
      endDate: json["endDate"],
      addNewDate: json["addNewDate"],
      endNewDate: json["endNewDate"],
      emirateName: json["emirateName"],
    );
  }

  Map<String?, dynamic> toJson() => {
        "contractID": contractId,
        "installments": installments,
        "emirateID": emirateId,
        "totalAmount": totalAmount,
        "amount": amount,
        "contractno": contractno,
        "fromDate": fromDate,
        "endDate": endDate,
        "addNewDate": addNewDate,
        "endNewDate": endNewDate,
        "emirateName": emirateName,
      };
}
