// To parse this JSON data, do
//
//     final getLpoTermsModel = getLpoTermsModelFromJson(jsonString);

import 'dart:convert';

GetLpoTermsModel getLpoTermsModelFromJson(String? str) =>
    GetLpoTermsModel.fromJson(json.decode(str!));

String? getLpoTermsModelToJson(GetLpoTermsModel data) =>
    json.encode(data.toJson());

class GetLpoTermsModel {
  GetLpoTermsModel({
    this.statusCode,
    this.status,
    this.message,
    this.lpoTerms,
  });

  String? statusCode;
  String? status;
  String? message;
  List<LpoTerm>? lpoTerms;

  factory GetLpoTermsModel.fromJson(Map<String?, dynamic> json) =>
      GetLpoTermsModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        lpoTerms: List<LpoTerm>.from(
            json["lpoTerms"].map((x) => LpoTerm.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "lpoTerms": List<dynamic>.from(lpoTerms!.map((x) => x.toJson())),
      };
}

class LpoTerm {
  LpoTerm({
    this.lpoPaymentId,
    this.lpoId,
    this.termName,
    this.amount,
    this.propertyName,
    this.propertyNameAr,
    this.lpoReference,
    this.lpoDate,
    this.termNameAr,
    this.paidBy,
    this.recievedBy,
  });

  dynamic lpoPaymentId;
  dynamic lpoId;
  String? termName;
  String? termNameAr;
  dynamic amount;
  String? propertyName;
  String? propertyNameAr;
  String? lpoReference;
  String? lpoDate;
  String? paidBy;
  String? recievedBy;

  factory LpoTerm.fromJson(Map<String?, dynamic> json) => LpoTerm(
        lpoPaymentId: json["lpoPaymentID"],
        lpoId: json["lpoID"],
        termName: json["termName"],
        termNameAr: json["termNameAR"],
        amount: json["amount"],
        propertyName: json["propertyName"],
        propertyNameAr: json["propertyNameAR"],
        lpoReference: json["lpoReference"],
        lpoDate: json["lpoDate"],
        paidBy: json["paidBy"],
        recievedBy: json["recievedBy"],
      );

  Map<String?, dynamic> toJson() => {
        "lpoPaymentID": lpoPaymentId,
        "lpoID": lpoId,
        "termName": termName,
        "amount": amount,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
        "lpoReference": lpoReference,
        "lpoDate": lpoDate,
        "paidBy": paidBy,
        "recievedBy": recievedBy,
      };
}
