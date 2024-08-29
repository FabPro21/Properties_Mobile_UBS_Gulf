// To parse this JSON data, do
//
//     final compareDevTokenModel = compareDevTokenModelFromJson(jsonString);

import 'dart:convert';

CompareDevTokenModel compareDevTokenModelFromJson(String? str) =>
    CompareDevTokenModel.fromJson(json.decode(str!));

String? compareDevTokenModelToJson(CompareDevTokenModel data) =>
    json.encode(data.toJson());

class CompareDevTokenModel {
  CompareDevTokenModel({
    this.statusCode,
    this.status,
    this.tokenValid,
  });

  String? statusCode;
  String? status;
  int? tokenValid;

  factory CompareDevTokenModel.fromJson(Map<String?, dynamic> json) =>
      CompareDevTokenModel(
        statusCode: json["statusCode"],
        status: json["status"],
        tokenValid: json["tokenValid"],
      );

  Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "tokenValid": tokenValid,
      };
}
