// To parse this JSON data, do
//
//     final publicReadNotificationModel = publicReadNotificationModelFromJson(jsonString);

import 'dart:convert';

PublicReadNotificationModel publicReadNotificationModelFromJson(String str) => PublicReadNotificationModel.fromJson(json.decode(str));

String publicReadNotificationModelToJson(PublicReadNotificationModel data) => json.encode(data.toJson());

class PublicReadNotificationModel {
    PublicReadNotificationModel({
        this.status,
        this.statusCode,
        this.message,
    });

    String status;
    String statusCode;
    String message;

    factory PublicReadNotificationModel.fromJson(Map<String, dynamic> json) => PublicReadNotificationModel(
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
