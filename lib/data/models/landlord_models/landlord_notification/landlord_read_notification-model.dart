// To parse this JSON data, do
//
//     final LandLordReadNotificationsModel = LandLordReadNotificationsModelFromJson(jsonString);

import 'dart:convert';

LandLordReadNotificationsModel landlordReadNotificationsModelFromJson(String? str) =>
    LandLordReadNotificationsModel.fromJson(json.decode(str!));

String? landlordReadNotificationsModelToJson(LandLordReadNotificationsModel data) =>
    json.encode(data.toJson());
 
class LandLordReadNotificationsModel {
  LandLordReadNotificationsModel({
    this.status,
    this.statusCode,
    this.message,
  });

  String? status;
  String? statusCode;
  String? message;

  factory LandLordReadNotificationsModel.fromJson(Map<String?, dynamic> json) =>
      LandLordReadNotificationsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
      };
}
