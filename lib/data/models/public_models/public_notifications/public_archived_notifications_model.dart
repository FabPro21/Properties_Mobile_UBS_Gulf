// To parse this JSON data, do
//
//     final publicArchivedNotificationModel = publicArchivedNotificationModelFromJson(jsonString);

import 'dart:convert';

PublicArchivedNotificationModel publicArchivedNotificationModelFromJson(String str) => PublicArchivedNotificationModel.fromJson(json.decode(str));

String publicArchivedNotificationModelToJson(PublicArchivedNotificationModel data) => json.encode(data.toJson());

class PublicArchivedNotificationModel {
    PublicArchivedNotificationModel({
        this.status,
        this.statusCode,
        this.message,
    });

    String status;
    String statusCode;
    String message;

    factory PublicArchivedNotificationModel.fromJson(Map<String, dynamic> json) => PublicArchivedNotificationModel(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
    };
}
