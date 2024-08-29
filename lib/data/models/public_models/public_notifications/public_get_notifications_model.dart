// To parse this JSON data, do
//
//     final publicGetNotificationModel = publicGetNotificationModelFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

PublicGetNotificationModel publicGetNotificationModelFromJson(String? str) =>
    PublicGetNotificationModel.fromJson(json.decode(str ?? ""));

class PublicGetNotificationModel {
  PublicGetNotificationModel({
    this.statusCode,
    this.status,
    this.notifications,
    this.message,
  });

  String? statusCode;
  String? status;
  List<Notification>? notifications;
  String? message;

  factory PublicGetNotificationModel.fromJson(Map<String?, dynamic> json) =>
      PublicGetNotificationModel(
        statusCode: json["statusCode"],
        status: json["status"],
        notifications: json["notifications"] != null
            ? List<Notification>.from(
                json["notifications"].map((x) => Notification.fromJson(x)))
            : [],
        message: json["message"],
      );
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
  CurrentStatus? currentStatus;
  int? notificationTypeId;
  bool? isRead;
  String? readOn;
  bool? sent;
  String? sentOn;
  String? batch;
  int? userId;
  UserName? userName;
  String? mobile;
  String? title;
  String? description;
  NotificationType? notificationType;
  int? totalRecords;
  String? titleAR;
  String? descriptionAR;

  factory Notification.fromJson(Map<String?, dynamic> json) => Notification(
      notificationId: json["notificationId"],
      createdOn: json["createdOn"],
      // currentStatus: currentStatusValues.map[json["currentStatus"]],
      currentStatus: json["currentStatus"] != null
          ? currentStatusValues.map[json["currentStatus"]]
          : null,
      notificationTypeId: json["notificationTypeId"],
      isRead: json["isRead"],
      readOn: json["readOn"],
      sent: json["sent"],
      sentOn: json["sentOn"],
      batch: json["batch"],
      userId: json["userId"],
      // userName: userNameValues.map[json["userName"]]!,
      userName: json["userName"] != null
          ? userNameValues.map[json["userName"]]
          : null,
      mobile: json["mobile"],
      title: json["title"],
      description: json["description"],
      // notificationType: notificationTypeValues.map[json["notificationType"]]!,
      notificationType: json["notificationType"] != null
          ? notificationTypeValues.map[json["notificationType"]]
          : null,
      totalRecords: json["totalRecords"],
      titleAR: json["titleAR"],
      descriptionAR: json["descriptionAR"]);
}

enum CurrentStatus { QUEUE }

final currentStatusValues = EnumValues({"Queue": CurrentStatus.QUEUE});

enum NotificationType { PUSH }

final notificationTypeValues = EnumValues({"Push": NotificationType.PUSH});

enum UserName { HASSAN_ALI_SYNC }

final userNameValues =
    EnumValues({" Hassan Ali Sync": UserName.HASSAN_ALI_SYNC});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map) : reverseMap = map.map((k, v) => MapEntry(v, k));

  Map<T, String> get reverse => reverseMap;
}


// // To parse this JSON data, do
// //
// //     final publicGetNotificationModel = publicGetNotificationModelFromJson(jsonString);

// // ignore_for_file: unnecessary_null_comparison

// import 'dart:convert';

// PublicGetNotificationModel publicGetNotificationModelFromJson(String? str) =>
//     PublicGetNotificationModel.fromJson(json.decode(str ?? ""));

// String? publicGetNotificationModelToJson(PublicGetNotificationModel data) =>
//     json.encode(data.toJson());

// class PublicGetNotificationModel {
//   PublicGetNotificationModel({
//     this.statusCode,
//     this.status,
//     this.notifications,
//     this.message,
//   });

//   String? statusCode;
//   String? status;
//   List<Notification>? notifications;
//   String? message;

//   factory PublicGetNotificationModel.fromJson(Map<String?, dynamic> json) =>
//       PublicGetNotificationModel(
//         statusCode: json["statusCode"],
//         status: json["status"],
//         notifications: List<Notification>.from(
//             json["notifications"].map((x) => Notification.fromJson(x))),
//         message: json["message"],
//       );

//   Map<String?, dynamic> toJson() => {
//         "statusCode": statusCode,
//         "status": status,
//         "notifications":
//             List<dynamic>.from(notifications!.map((x) => x.toJson())),
//         "message": message,
//       };
// }

// class Notification {
//   Notification(
//       {this.notificationId,
//       this.createdOn,
//       this.currentStatus,
//       this.notificationTypeId,
//       this.isRead,
//       this.readOn,
//       this.sent,
//       this.sentOn,
//       this.batch,
//       this.userId,
//       this.userName,
//       this.mobile,
//       this.title,
//       this.description,
//       this.notificationType,
//       this.totalRecords,
//       this.titleAR,
//       this.descriptionAR});

//   int? notificationId;
//   String? createdOn;
//   CurrentStatus? currentStatus;
//   int? notificationTypeId;
//   bool? isRead;
//   String? readOn;
//   bool? sent;
//   String? sentOn;
//   String? batch;
//   int? userId;
//   UserName? userName;
//   String? mobile;
//   String? title;
//   String? description;
//   NotificationType? notificationType;
//   int? totalRecords;
//   String? titleAR;
//   String? descriptionAR;

//   factory Notification.fromJson(Map<String?, dynamic> json) => Notification(
//       notificationId: json["notificationId"],
//       createdOn: json["createdOn"],
//       currentStatus: currentStatusValues.map[json["currentStatus"]],
//       notificationTypeId: json["notificationTypeId"],
//       isRead: json["isRead"],
//       readOn: json["readOn"],
//       sent: json["sent"],
//       sentOn: json["sentOn"],
//       batch: json["batch"],
//       userId: json["userId"],
//       userName: userNameValues.map[json["userName"]]!,
//       mobile: json["mobile"],
//       title: json["title"],
//       description: json["description"],
//       notificationType: notificationTypeValues.map[json["notificationType"]]!,
//       totalRecords: json["totalRecords"],
//       titleAR: json["titleAR"],
//       descriptionAR: json["descriptionAR"]);

//   Map<String?, dynamic> toJson() => {
//         "notificationId": notificationId,
//         "createdOn": createdOn,
//         "currentStatus": currentStatusValues.reverse[currentStatus],
//         "notificationTypeId": notificationTypeId,
//         "isRead": isRead,
//         "readOn": readOn,
//         "sent": sent,
//         "sentOn": sentOn,
//         "batch": batch,
//         "userId": userId,
//         "userName": userNameValues.reverse[userName],
//         "mobile": mobile,
//         "title": title,
//         "description": description,
//         "notificationType": notificationTypeValues.reverse[notificationType],
//         "totalRecords": totalRecords,
//       };
// }

// enum CurrentStatus { QUEUE }

// final currentStatusValues = EnumValues({"Queue": CurrentStatus.QUEUE});

// enum NotificationType { PUSH }

// final notificationTypeValues = EnumValues({"Push": NotificationType.PUSH});

// enum UserName { HASSAN_ALI_SYNC }

// final userNameValues =
//     EnumValues({" Hassan Ali Sync": UserName.HASSAN_ALI_SYNC});

// class EnumValues<T> {
//   late Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
