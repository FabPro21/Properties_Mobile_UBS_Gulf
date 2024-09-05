// To parse this JSON data, do
//
//     final contractExpire30Days = contractExpire30DaysFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ContractExpire30Days contractExpire30DaysFromJson(String? str) =>
    ContractExpire30Days.fromJson(json.decode(str!));

String? contractExpire30DaysToJson(ContractExpire30Days data) =>
    json.encode(data.toJson());

class ContractExpire30Days {
  ContractExpire30Days({
    this.record,
    this.status,
  });

  List<Record>? record;
  String? status;

  factory ContractExpire30Days.fromJson(Map<String?, dynamic> json) =>
      ContractExpire30Days(
        record:
            List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
        status: json["status"],
      );

  Map<String?, dynamic> toJson() => {
        "record": List<dynamic>.from(record!.map((x) => x.toJson())),
        "status": status,
      };
}

class Record {
  Record(
      {this.contractId,
      this.contractDate,
      this.fromdate,
      this.todate,
      this.installments,
      this.rentAmount,
      this.rentforstay,
      this.propertyName,
      this.propertyNameAr,
      this.status,
      this.statusAr,
      this.contractNo});

  int? contractId;
  String? contractDate;
  String? fromdate;
  String? todate;
  int? installments;
  String? rentAmount;
  String? rentforstay;
  String? propertyName;
  String? propertyNameAr;
  String? status;
  String? statusAr;
  String? contractNo;

  factory Record.fromJson(Map<String?, dynamic> json) {
    final amountFormat = NumberFormat('#,##0.00', 'AR');
    String? rentAmount = amountFormat.format(json["rentAmount"] ?? 0);
    String? rentforstay = amountFormat.format(json["rentforstay"] ?? 0);
    return Record(
        contractId: json["contractID"],
        contractDate: json["contractDate"],
        fromdate: json["fromdate"],
        todate: json["todate"],
        installments: json["installments"],
        rentAmount: rentAmount,
        rentforstay: rentforstay,
        propertyName: json["propertyName"],
        propertyNameAr: json['propertyNameAR'] ?? '_',
        status: json["status"],
        statusAr: json["statusAR"],
        contractNo: json["contractno"]);
  }

  Map<String?, dynamic> toJson() => {
        "contractID": contractId,
        "contractDate": contractDate,
        "fromdate": fromdate,
        "todate": todate,
        "installments": installments,
        "rentAmount": rentAmount,
        "rentforstay": rentforstay,
      };
}
