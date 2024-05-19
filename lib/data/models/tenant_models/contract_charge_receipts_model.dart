// To parse this JSON data, do
//
//     final contractChargeReceiptsModel = contractChargeReceiptsModelFromJson(jsonString);

import 'dart:convert';

ContractChargeReceiptsModel contractChargeReceiptsModelFromJson(String str) =>
    ContractChargeReceiptsModel.fromJson(json.decode(str));

String contractChargeReceiptsModelToJson(ContractChargeReceiptsModel data) =>
    json.encode(data.toJson());

class ContractChargeReceiptsModel {
  ContractChargeReceiptsModel({
    this.status,
    this.statusCode,
    this.receipts,
    this.message,
  });

  String status;
  String statusCode;
  List<Receipt> receipts;
  String message;

  factory ContractChargeReceiptsModel.fromJson(Map<String, dynamic> json) =>
      ContractChargeReceiptsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        receipts: List<Receipt>.from(
            json["receipts"].map((x) => Receipt.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "receipts": List<dynamic>.from(receipts.map((x) => x.toJson())),
        "message": message,
      };
}

class Receipt {
  Receipt({
    this.paymentAmount,
    this.receiptNo,
    this.transactionDate,
    this.paymentType,
  });

  dynamic paymentAmount;
  String receiptNo;
  String transactionDate;
  String paymentType;

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        paymentAmount: json["paymentAmount"],
        receiptNo: json["receiptNo"],
        transactionDate: json["transactionDate"],
        paymentType: json["paymentType"],
      );

  Map<String, dynamic> toJson() => {
        "paymentAmount": paymentAmount,
        "receiptNo": receiptNo,
        "transactionDate": transactionDate,
        "paymentType": paymentType,
      };
}
