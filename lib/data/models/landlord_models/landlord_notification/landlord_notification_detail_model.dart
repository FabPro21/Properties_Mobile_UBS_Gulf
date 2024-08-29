// To parse this JSON data, do
//
//     final LandlordNotificationsDetailModel = LandlordNotificationsDetailModelFromJson(jsonString);

import 'dart:convert';

LandlordNotificationsDetailModel landlordNotificationsDetailModelFromJson(
        String? str) =>
    LandlordNotificationsDetailModel.fromJson(json.decode(str!));

String? landlordNotificationsDetailModelToJson(
        LandlordNotificationsDetailModel data) =>
    json.encode(data.toJson());

class LandlordNotificationsDetailModel {
  LandlordNotificationsDetailModel({
    this.statusCode,
    this.status,
    this.notification,
    this.message,
  });

  String? statusCode;
  String? status;
  Notification? notification;
  String? message;

  factory LandlordNotificationsDetailModel.fromJson(Map<String?, dynamic> json) =>
      LandlordNotificationsDetailModel(
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
    this.titleAR,
    this.description,
    this.descriptionAR,
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
  String? titleAR;
  String? description;
  String? descriptionAR;
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
        titleAR: json["titleAR"],
        description: json["description"],
        descriptionAR: json["descriptionAR"],
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
        "titleAR": titleAR,
        "description": description,
        "descriptionAR": descriptionAR,
        "notificationType": notificationType,
        "totalRecords": totalRecords,
      };
}
