// To parse this JSON data, do
//
//     final getEmirateModel = getEmirateModelFromJson(jsonString);

import 'dart:convert';

GetEmirateModel getEmirateModelFromJson(String str) =>
    GetEmirateModel.fromJson(json.decode(str));

class GetEmirateModel {
  GetEmirateModel({
    this.statusCode,
    this.status,
    this.message,
    this.emirate,
  });

  String statusCode;
  String status;
  String message;
  List<Emirate> emirate;

  factory GetEmirateModel.fromJson(Map<String, dynamic> json) =>
      GetEmirateModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        emirate:
            List<Emirate>.from(json["emirate"].map((x) => Emirate.fromJson(x))),
      );
}

class Emirate {
  Emirate({
    this.emirateId,
    this.emirateName,
    this.emirateNameAr,
  });

  int emirateId;
  String emirateName;
  String emirateNameAr;

  factory Emirate.fromJson(Map<String, dynamic> json) => Emirate(
        emirateId: json["emirateID"],
        emirateName: json["emirateName"],
        emirateNameAr: json["emirateNameAR"],
      );
}
