// To parse this JSON data, do
//
//     final tenantReadNotificationsModel = tenantReadNotificationsModelFromJson(jsonString);

import 'dart:convert';

TenantReadNotificationsModel tenantReadNotificationsModelFromJson(String? str) =>
    TenantReadNotificationsModel.fromJson(json.decode(str!));

String? tenantReadNotificationsModelToJson(TenantReadNotificationsModel data) =>
    json.encode(data.toJson());
 
class TenantReadNotificationsModel {
  TenantReadNotificationsModel({
    this.status,
    this.statusCode,
    this.message,
  });

  String? status;
  String? statusCode;
  String? message;

  factory TenantReadNotificationsModel.fromJson(Map<String?, dynamic> json) =>
      TenantReadNotificationsModel(
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
