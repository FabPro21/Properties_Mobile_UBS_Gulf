// To parse this JSON data, do
//
//     final getExtensionPeriodModel = getExtensionPeriodModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

GetExtensionPeriodModel getExtensionPeriodModelFromJson(String? str) =>
    GetExtensionPeriodModel.fromJson(json.decode(str!));

String? getExtensionPeriodModelToJson(GetExtensionPeriodModel data) =>
    json.encode(data.toJson());

class GetExtensionPeriodModel {
  GetExtensionPeriodModel({
    this.status,
    this.extensionPeriod,
  });

  String? status;
  List<ExtensionPeriod>? extensionPeriod;

  factory GetExtensionPeriodModel.fromJson(Map<String?, dynamic> json) =>
      GetExtensionPeriodModel(
        status: json["status"],
        extensionPeriod: List<ExtensionPeriod>.from(
            json["extensionPeriod"].map((x) => ExtensionPeriod.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "extensionPeriod":
            List<dynamic>.from(extensionPeriod!.map((x) => x.toJson())),
      };
}

class ExtensionPeriod {
  ExtensionPeriod({
    this.duration,
    this.amount,
    this.extensionDetail,
  });

  String? duration;
  String? amount;
  ExtensionDetail? extensionDetail;

  factory ExtensionPeriod.fromJson(Map<String?, dynamic> json) {
    final amountFormat = NumberFormat('#,##0.00', 'AR');
    String? amount = amountFormat.format(json["amount"] ?? 0);
    return ExtensionPeriod(
      duration: json["duration"],
      amount: amount,
      extensionDetail: ExtensionDetail.fromJson(json["extensionDetail"]),
    );
  }

  Map<String?, dynamic> toJson() => {
        "duration": duration,
        "amount": amount,
        "extensionDetail": extensionDetail!.toJson(),
      };
}

class ExtensionDetail {
  ExtensionDetail(
      {this.contractId,
      this.contractno,
      this.fromDate,
      this.endDate,
      this.addNewDate,
      this.endNewDate,
      this.emirateName});

  int? contractId;
  String? contractno;
  String? fromDate;
  String? endDate;
  String? addNewDate;
  String? endNewDate;
  String? emirateName;

  factory ExtensionDetail.fromJson(Map<String?, dynamic> json) =>
      ExtensionDetail(
          contractId: json["contractID"],
          contractno: json["contractno"],
          fromDate: json["fromDate"],
          endDate: json["endDate"],
          addNewDate: json["addNewDate"],
          endNewDate: json["endNewDate"],
          emirateName: json["emirateName"]);

  Map<String?, dynamic> toJson() => {
        "contractID": contractId,
        "contractno": contractno,
        "fromDate": fromDate,
        "endDate": endDate,
        "addNewDate": addNewDate,
        "endNewDate": endNewDate,
      };
}
