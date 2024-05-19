// To parse this JSON data, do
//
//     final municipalInstructions = municipalInstructionsFromJson(jsonString);

import 'dart:convert';

MunicipalInstructions municipalInstructionsFromJson(String str) =>
    MunicipalInstructions.fromJson(json.decode(str));

String municipalInstructionsToJson(MunicipalInstructions data) =>
    json.encode(data.toJson());

class MunicipalInstructions {
  MunicipalInstructions({
    this.record,
    this.status,
    this.statusCode,
    this.message,
  });

  String record;
  String status;
  String statusCode;
  String message;

  factory MunicipalInstructions.fromJson(Map<String, dynamic> json) =>
      MunicipalInstructions(
        record: json["record"],
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "record": record,
        "status": status,
        "statusCode": statusCode,
        "message": message,
      };
}
