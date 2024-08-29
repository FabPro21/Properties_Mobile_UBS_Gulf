// To parse this JSON data, do
//
//     final LandlordArchiveNotificationsModel = LandlordArchiveNotificationsModelFromJson(jsonString);

import 'dart:convert';

LandlordArchiveNotificationsModel landlordArchiveNotificationsModelFromJson(
        String? str) =>
    LandlordArchiveNotificationsModel.fromJson(json.decode(str!));

String? landlordArchiveNotificationsModelToJson(
        LandlordArchiveNotificationsModel data) =>
    json.encode(data.toJson());

class LandlordArchiveNotificationsModel {
  LandlordArchiveNotificationsModel({
    this.status,
    this.statusCode,
    this.message,
  });

  String? status;
  String? statusCode;
  String? message;

  factory LandlordArchiveNotificationsModel.fromJson(Map<String?, dynamic> json) =>
      LandlordArchiveNotificationsModel(
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
