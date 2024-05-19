// To parse this JSON data, do
//
//     final getContractChequesModel = getContractChequesModelFromJson(jsonString);

import 'dart:convert';

GetContractChequesModel getContractChequesModelFromJson(String str) =>
    GetContractChequesModel.fromJson(json.decode(str));

String getContractChequesModelToJson(GetContractChequesModel data) =>
    json.encode(data.toJson());

class GetContractChequesModel {
  GetContractChequesModel({
    this.status,
    this.statusCode,
    this.transactionCheque,
    this.message,
  });

  String status;
  String statusCode;
  List<TransactionCheque> transactionCheque;
  String message;

  factory GetContractChequesModel.fromJson(Map<String, dynamic> json) =>
      GetContractChequesModel(
        status: json["status"],
        statusCode: json["statusCode"],
        transactionCheque: List<TransactionCheque>.from(
            json["transactionCheque"]
                .map((x) => TransactionCheque.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "transactionCheque":
            List<dynamic>.from(transactionCheque.map((x) => x.toJson())),
        "message": message,
      };
}

class TransactionCheque {
  TransactionCheque(
      {this.transactionId,
      this.chequeNo,
      this.chequeDate,
      this.bankName,
      this.chequeAmount,
      this.chequeStatus,
      this.bankNameAr,
      this.chequeStatusAR});

  dynamic transactionId;
  String chequeNo;
  String chequeDate;
  String bankName;
  dynamic chequeAmount;
  String chequeStatus;
  String bankNameAr;
  String chequeStatusAR;

  factory TransactionCheque.fromJson(Map<String, dynamic> json) =>
      TransactionCheque(
          transactionId: json["transactionID"],
          chequeNo: json["chequeNo"],
          chequeDate: json["chequeDate"],
          bankName: json["bankName"],
          chequeAmount: json["chequeAmount"],
          chequeStatus: json["chequeStatus"],
          bankNameAr: json["bankNameAR"],
          chequeStatusAR: json["chequeStatusAR"]);

  Map<String, dynamic> toJson() => {
        "transactionID": transactionId,
        "chequeNo": chequeNo,
        "chequeDate": chequeDate,
        "bankName": bankName,
        "chequeAmount": chequeAmount,
        "chequeStatus": chequeStatus,
        "bankNameAR": bankNameAr,
      };
}
