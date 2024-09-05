// To parse this JSON data, do
//
//     final tenantArchiveNotificationsModel = tenantArchiveNotificationsModelFromJson(jsonString);

import 'dart:convert';

TenantArchiveNotificationsModel tenantArchiveNotificationsModelFromJson(
        String? str) =>
    TenantArchiveNotificationsModel.fromJson(json.decode(str!));

String? tenantArchiveNotificationsModelToJson(
        TenantArchiveNotificationsModel data) =>
    json.encode(data.toJson());

class TenantArchiveNotificationsModel {
  TenantArchiveNotificationsModel({
    this.status,
    this.statusCode,
    this.message,
  });

  String? status;
  String? statusCode;
  String? message;

  factory TenantArchiveNotificationsModel.fromJson(Map<String?, dynamic> json) =>
      TenantArchiveNotificationsModel(
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
