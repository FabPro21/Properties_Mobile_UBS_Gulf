// To parse this JSON data, do
//
//     final vendorGetNotificationModel = vendorGetNotificationModelFromJson(jsonString);

import 'dart:convert';

VendorGetNotificationModel vendorGetNotificationModelFromJson(String? str) => VendorGetNotificationModel.fromJson(json.decode(str!));

String? vendorGetNotificationModelToJson(VendorGetNotificationModel data) => json.encode(data.toJson());

class VendorGetNotificationModel {
    VendorGetNotificationModel({
        this.statusCode,
        this.status,
        this.notifications,
        this.message,
    });

    String? statusCode;
    String? status;
    List<Notification>? notifications;
    String? message;

    factory VendorGetNotificationModel.fromJson(Map<String?, dynamic> json) => VendorGetNotificationModel(
        statusCode: json["statusCode"],
        status: json["status"],
        notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
        message: json["message"],
    );

    Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "notifications": List<dynamic>.from(notifications!.map((x) => x.toJson())),
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
    CurrentStatus? currentStatus;
    int? notificationTypeId;
    bool? isRead;
    String? readOn;
    bool? sent;
    dynamic sentOn;
    String? batch;
    int? userId;
    UserName? userName;
    String? mobile;
    String? title;
    dynamic descriptionAr;
    dynamic titleAr;
    String? description;
    NotificationType? notificationType;
    int? totalRecords;

    factory Notification.fromJson(Map<String?, dynamic> json) => Notification(
        notificationId: json["notificationId"],
        createdOn: json["createdOn"],
        currentStatus: currentStatusValues.map![json["currentStatus"]],
        notificationTypeId: json["notificationTypeId"],
        isRead: json["isRead"],
        readOn: json["readOn"] == null ? null : json["readOn"],
        sent: json["sent"],
        sentOn: json["sentOn"],
        batch: json["batch"],
        userId: json["userId"],
        userName: userNameValues.map![json["userName"]],
        mobile: json["mobile"],
        title: json["title"],
        descriptionAr: json["descriptionAR"],
        titleAr: json["titleAR"],
        description: json["description"],
        notificationType: notificationTypeValues.map![json["notificationType"]],
        totalRecords: json["totalRecords"],
    );

    Map<String?, dynamic> toJson() => {
        "notificationId": notificationId,
        "createdOn": createdOn,
        "currentStatus": currentStatusValues.reverse[currentStatus],
        "notificationTypeId": notificationTypeId,
        "isRead": isRead,
        "readOn": readOn == null ? null : readOn,
        "sent": sent,
        "sentOn": sentOn,
        "batch": batch,
        "userId": userId,
        "userName": userNameValues.reverse[userName],
        "mobile": mobile,
        "title": title,
        "descriptionAR": descriptionAr,
        "titleAR": titleAr,
        "description": description,
        "notificationType": notificationTypeValues.reverse[notificationType],
        "totalRecords": totalRecords,
    };
}

enum CurrentStatus { READ, QUEUE }

final currentStatusValues = EnumValues({
    "Queue": CurrentStatus.QUEUE,
    "Read": CurrentStatus.READ
});

enum NotificationType { PUSH }

final notificationTypeValues = EnumValues({
    "Push": NotificationType.PUSH
});

enum UserName { HASSAN_ALI_SYNC }
final userNameValues = EnumValues({
    " Hassan Ali Sync": UserName.HASSAN_ALI_SYNC
});

class EnumValues<T> {
    Map<String?, T>? map;
    Map<T, String?>? reverseMap;

    EnumValues(this.map);

    Map<T, String?> get reverse {
        if (reverseMap == null) {
            reverseMap = map!.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
