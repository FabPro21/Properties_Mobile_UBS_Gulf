// To parse this JSON data, do
//
//     final publicCountNotificationModel = publicCountNotificationModelFromJson(jsonString);

import 'dart:convert';

PublicCountNotificationModel publicCountNotificationModelFromJson(String? str) => PublicCountNotificationModel.fromJson(json.decode(str!));

String? publicCountNotificationModelToJson(PublicCountNotificationModel data) => json.encode(data.toJson());

class PublicCountNotificationModel {
    PublicCountNotificationModel({
        this.statusCode,
        this.status,
        this.notifications,
        this.message,
    });

    String? statusCode;
    String? status;
    int? notifications;
    String? message;

    factory PublicCountNotificationModel.fromJson(Map<String?, dynamic> json) => PublicCountNotificationModel(
        statusCode: json["statusCode"],
        status: json["status"],
        notifications: json["notifications"],
        message: json["message"],
    );

    Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "notifications": notifications,
        "message": message,
    };
}
