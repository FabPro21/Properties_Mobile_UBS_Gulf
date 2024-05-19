// To parse this JSON data, do
//
//     final validateUserModel = validateUserModelFromJson(jsonString);

import 'dart:convert';

ValidateUserModel validateUserModelFromJson(String str) =>
    ValidateUserModel.fromJson(json.decode(str));

String validateUserModelToJson(ValidateUserModel data) =>
    json.encode(data.toJson());

class ValidateUserModel {
  ValidateUserModel({
    this.statusCode,
    this.status,
    this.message,
    this.otpCode,
  });

  String statusCode;
  String status;
  String message;
  String otpCode;

  factory ValidateUserModel.fromJson(Map<String, dynamic> json) =>
      ValidateUserModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        otpCode: json["otpCode"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "otpCode": otpCode,
      };
}
