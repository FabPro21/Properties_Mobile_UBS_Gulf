// To parse this JSON data, do
//
//     final getTenantNotificationsModel = getTenantNotificationsModelFromJson(jsonString);

import 'dart:convert';

GetTenantNotificationsModel getTenantNotificationsModelFromJson(String? str) =>
    GetTenantNotificationsModel.fromJson(json.decode(str!));

String? getTenantNotificationsModelToJson(GetTenantNotificationsModel data) =>
    json.encode(data.toJson());

class GetTenantNotificationsModel {
  GetTenantNotificationsModel({
    this.statusCode,
    this.status,
    this.notifications,
    this.message,
  });

  String? statusCode;
  String? status;
  List<Notification>? notifications;
  String? message;

  factory GetTenantNotificationsModel.fromJson(Map<String?, dynamic> json) =>
      GetTenantNotificationsModel(
        statusCode: json["statusCode"],
        status: json["status"],
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "notifications":
            List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "message": message,
      };
}

class Notification {
  Notification(
      {this.notificationId,
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
      this.description,
      this.notificationType,
      this.totalRecords,
      this.titleAR,
      this.descriptionAR});

  int? notificationId;
  String? createdOn;
  String? currentStatus;
  int? notificationTypeId;
  bool? isRead;
  String? readOn;
  bool? sent;
  String? sentOn;
  String? batch;
  int? userId;
  String? userName;
  String? mobile;
  String? title;
  String? description;
  String? notificationType;
  int? totalRecords;
  String? titleAR;
  String? descriptionAR;

  factory Notification.fromJson(Map<String?, dynamic> json) => Notification(
      notificationId: json["notificationId"],
      createdOn: json["createdOn"],
      currentStatus: json["currentStatus"],
      notificationTypeId: json["notificationTypeId"],
      isRead: json["isRead"],
      readOn: json["readOn"] == null ? null : json["readOn"],
      sent: json["sent"],
      sentOn: json["sentOn"],
      batch: json["batch"],
      userId: json["userId"],
      userName: json["userName"],
      mobile: json["mobile"],
      title: json["title"],
      description: json["description"],
      notificationType: json["notificationType"],
      totalRecords: json["totalRecords"],
      titleAR: json["titleAR"],
      descriptionAR: json["descriptionAR"]);

  Map<String?, dynamic> toJson() => {
        "notificationId": notificationId,
        "createdOn": createdOn,
        "currentStatus": currentStatus,
        "notificationTypeId": notificationTypeId,
        "isRead": isRead,
        "readOn": readOn == null ? null : readOn,
        "sent": sent,
        "sentOn": sentOn,
        "batch": batch,
        "userId": userId,
        "userName": userName,
        "mobile": mobile,
        "title": title,
        "description": description,
        "notificationType": notificationType,
        "totalRecords": totalRecords,
      };
}
