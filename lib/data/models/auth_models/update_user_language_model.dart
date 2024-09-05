// To parse this JSON data, do
//
//     final updateUserLanguageModel = updateUserLanguageModelFromJson(jsonString);

import 'dart:convert';

UpdateUserLanguageModel updateUserLanguageModelFromJson(String? str) =>
    UpdateUserLanguageModel.fromJson(json.decode(str!));

String? updateUserLanguageModelToJson(UpdateUserLanguageModel data) =>
    json.encode(data.toJson());

class UpdateUserLanguageModel {
  UpdateUserLanguageModel({
    this.message,
    this.status,
    this.statusCode,
  });

  String? message;
  String? status;
  String? statusCode;

  factory UpdateUserLanguageModel.fromJson(Map<String?, dynamic> json) =>
      UpdateUserLanguageModel(
        message: json["message"],
        status: json["status"],
        statusCode: json["statusCode"],
      );

  Map<String?, dynamic> toJson() => {
        "message": message,
        "status": status,
        "statusCode": statusCode,
      };
}
