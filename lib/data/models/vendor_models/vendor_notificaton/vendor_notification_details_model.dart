// To parse this JSON data, do
//
//     final vendorNotificationDetailsModel = vendorNotificationDetailsModelFromJson(jsonString);

import 'dart:convert';

VendorNotificationDetailsModel vendorNotificationDetailsModelFromJson(String? str) => VendorNotificationDetailsModel.fromJson(json.decode(str!));

String? vendorNotificationDetailsModelToJson(VendorNotificationDetailsModel data) => json.encode(data.toJson());

class VendorNotificationDetailsModel {
    VendorNotificationDetailsModel({
        this.statusCode,
        this.status,
        this.notification,
        this.message,
    });

    String? statusCode;
    String? status;
    Notification? notification;
    String? message;

    factory VendorNotificationDetailsModel.fromJson(Map<String?, dynamic> json) => VendorNotificationDetailsModel(
        statusCode: json["statusCode"],
        status: json["status"],
        notification: Notification.fromJson(json["notification"]),
        message: json["message"],
    );

    Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "notification": notification!.toJson(),
        "message": message,
    };
}

class Notification {
    Notification({
        this.notificationId,
        this.createdOn,
        this.currentStatus,
        this.notificationTypeId,
        this.isRead,
        this.readOn,
        this.sent,
        this.sentOn,
        this.batch,
        this.userId,
        this.userName,
        this.mobile,
        this.title,
        this.descriptionAr,
        this.titleAr,
        this.description,
        this.notificationType,
        this.totalRecords,
    });

    int? notificationId;
    String? createdOn;
    String? currentStatus;
    int? notificationTypeId;
    bool? isRead;
    dynamic readOn;
    bool? sent;
    dynamic sentOn;
    dynamic batch;
    int? userId;
    dynamic userName;
    dynamic mobile;
    String? title;
    dynamic descriptionAr;
    dynamic titleAr;
    String? description;
    dynamic notificationType;
    int? totalRecords;

    factory Notification.fromJson(Map<String?, dynamic> json) => Notification(
        notificationId: json["notificationId"],
        createdOn: json["createdOn"],
        currentStatus: json["currentStatus"],
        notificationTypeId: json["notificationTypeId"],
        isRead: json["isRead"],
        readOn: json["readOn"],
        sent: json["sent"],
        sentOn: json["sentOn"],
        batch: json["batch"],
        userId: json["userId"],
        userName: json["userName"],
        mobile: json["mobile"],
        title: json["title"],
        descriptionAr: json["descriptionAR"],
        titleAr: json["titleAR"],
        description: json["description"],
        notificationType: json["notificationType"],
        totalRecords: json["totalRecords"],
    );

    Map<String?, dynamic> toJson() => {
        "notificationId": notificationId,
        "createdOn": createdOn,
        "currentStatus": currentStatus,
        "notificationTypeId": notificationTypeId,
        "isRead": isRead,
        "readOn": readOn,
        "sent": sent,
        "sentOn": sentOn,
        "batch": batch,
        "userId": userId,
        "userName": userName,
        "mobile": mobile,
        "title": title,
        "descriptionAR": descriptionAr,
        "titleAR": titleAr,
        "description": description,
        "notificationType": notificationType,
        "totalRecords": totalRecords,
    };
}
