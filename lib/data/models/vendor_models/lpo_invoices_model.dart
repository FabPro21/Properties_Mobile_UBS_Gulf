// To parse this JSON data, do
//
//     final lpoInvoicesModel = lpoInvoicesModelFromJson(jsonString);

import 'dart:convert';

LpoInvoicesModel lpoInvoicesModelFromJson(String str) =>
    LpoInvoicesModel.fromJson(json.decode(str));

String lpoInvoicesModelToJson(LpoInvoicesModel data) =>
    json.encode(data.toJson());

class LpoInvoicesModel {
  LpoInvoicesModel({
    this.status,
    this.statusCode,
    this.invoice,
    this.message,
  });

  String status;
  String statusCode;
  List<Invoice> invoice;
  String message;

  factory LpoInvoicesModel.fromJson(Map<String, dynamic> json) =>
      LpoInvoicesModel(
        status: json["status"],
        statusCode: json["statusCode"],
        invoice:
            List<Invoice>.from(json["invoice"].map((x) => Invoice.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "invoice": List<dynamic>.from(invoice.map((x) => x.toJson())),
        "message": message,
      };
}

class Invoice {
  Invoice({
    this.lpono,
    this.supplierRefNo,
    this.requestDate,
    this.invoiceNumber,
    this.invoiceDate,
    this.invoiceAmount,
    this.statusNameAr,
    this.statusName,
  });

  String lpono;
  String supplierRefNo;
  String requestDate;
  String invoiceNumber;
  String invoiceDate;
  dynamic invoiceAmount;
  String statusName;
  String statusNameAr;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        lpono: json["lpono"],
        supplierRefNo: json["supplierRefNo"],
        requestDate: json["requestDate"],
        invoiceNumber: json["invoiceNumber"],
        invoiceDate: json["invoiceDate"],
        invoiceAmount: json["invoiceAmount"],
        statusName: json["statusName"],
        statusNameAr: json["statusNameAr"],
      );

  Map<String, dynamic> toJson() => {
        "lpono": lpono,
        "supplierRefNo": supplierRefNo,
        "requestDate": requestDate,
        "invoiceNumber": invoiceNumber,
        "invoiceDate": invoiceDate,
        "invoiceAmount": invoiceAmount,
        "statusName": statusName,
      };
}
