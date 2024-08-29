// To parse this JSON data, do
//
//     final contractInvoicesModel = contractInvoicesModelFromJson(jsonString);

import 'dart:convert';

ContractInvoicesModel contractInvoicesModelFromJson(String? str) =>
    ContractInvoicesModel.fromJson(json.decode(str!));

String? contractInvoicesModelToJson(ContractInvoicesModel data) =>
    json.encode(data.toJson());

class ContractInvoicesModel {
  ContractInvoicesModel({
    this.status,
    this.statusCode,
    this.invoice,
    this.message,
  });

  String? status;
  String? statusCode;
  List<Invoice>? invoice;
  String? message;

  factory ContractInvoicesModel.fromJson(Map<String?, dynamic> json) =>
      ContractInvoicesModel(
        status: json["status"],
        statusCode: json["statusCode"],
        invoice:
            List<Invoice>.from(json["invoice"].map((x) => Invoice.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "invoice": List<dynamic>.from(invoice!.map((x) => x.toJson())),
        "message": message,
      };
}

class Invoice {
  Invoice({
    this.contractNo,
    this.supplierRefNo,
    this.requestDate,
    this.invoiceNumber,
    this.invoiceDate,
    this.invoiceAmount,
    this.statusName,
  });

  String? contractNo;
  String? supplierRefNo;
  String? requestDate;
  String? invoiceNumber;
  String? invoiceDate;
  dynamic invoiceAmount;
  String? statusName;

  factory Invoice.fromJson(Map<String?, dynamic> json) => Invoice(
        contractNo: json["contractNO"],
        supplierRefNo: json["supplierRefNo"],
        requestDate: json["requestDate"],
        invoiceNumber: json["invoiceNumber"],
        invoiceDate: json["invoiceDate"],
        invoiceAmount: json["invoiceAmount"],
        statusName: json["statusName"],
      );

  Map<String?, dynamic> toJson() => {
        "contractNO": contractNo,
        "supplierRefNo": supplierRefNo,
        "requestDate": requestDate,
        "invoiceNumber": invoiceNumber,
        "invoiceDate": invoiceDate,
        "invoiceAmount": invoiceAmount,
        "statusName": statusName,
      };
}
