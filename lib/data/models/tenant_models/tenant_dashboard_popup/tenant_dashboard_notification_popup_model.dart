// To parse this JSON data, do
//
//     final tenantDashboardNotificationPopupModel = tenantDashboardNotificationPopupModelFromJson(jsonString);

import 'dart:convert';

TenantDashboardNotificationPopupModel
    tenantDashboardNotificationPopupModelFromJson(String? str) =>
        TenantDashboardNotificationPopupModel.fromJson(json.decode(str!));

String? tenantDashboardNotificationPopupModelToJson(
        TenantDashboardNotificationPopupModel data) =>
    json.encode(data.toJson());

class TenantDashboardNotificationPopupModel {
  String? statusCode;
  String? status;
  String? message;
  List<Notifications>? notifications;

  TenantDashboardNotificationPopupModel(
      {this.statusCode, this.status, this.message, this.notifications});

  TenantDashboardNotificationPopupModel.fromJson(Map<String?, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (notifications != null) {
      data['notifications'] =
          notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? contractno;
  String? fromDate;
  String? toDate;
  int? stageId;
  int? notificationId;
  int? recordId;
  String? title;
  String? titleAr;
  String? recordType;
  String? description;
  String? descriptionAr;
  String? createdOn;
  int? dueActionid;
  int? caseId;
  bool? showExtend;

  Notifications(
      {this.contractno,
      this.fromDate,
      this.toDate,
      this.stageId,
      this.notificationId,
      this.recordId,
      this.title,
      this.titleAr,
      this.recordType,
      this.description,
      this.descriptionAr,
      this.createdOn,
      this.dueActionid,
      this.caseId,
      this.showExtend,
      });

  Notifications.fromJson(Map<String?, dynamic> json) {
    contractno = json['contractno'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    stageId = json['stageId'];
    notificationId = json['notificationId'];
    recordId = json['recordId'];
    title = json['title'];
    titleAr = json['titleAr'];
    recordType = json['recordType'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    createdOn = json['createdOn'];
    dueActionid = json['dueActionid'];
    caseId = json['caseId'];
    showExtend = json['showExtend'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['contractno'] = contractno;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['stageId'] = stageId;
    data['notificationId'] = notificationId;
    data['recordId'] = recordId;
    data['title'] = title;
    data['titleAr'] = titleAr;
    data['recordType'] = recordType;
    data['description'] = description;
    data['descriptionAr'] = descriptionAr;
    data['createdOn'] = createdOn;
    data['dueActionid'] = dueActionid;
    data['caseId'] = caseId;
    data['showExtend'] = showExtend;
    return data;
  }
}

// class TenantDashboardNotificationPopupModel {
//   TenantDashboardNotificationPopupModel({
//     this.statusCode,
//     this.status,
//     this.message,
//     this.notifications,
//   });

//   String? statusCode;
//   String? status;
//   String? message;
//   List<Notification> notifications;

//   factory TenantDashboardNotificationPopupModel.fromJson(
//           Map<String?, dynamic> json) =>
//       TenantDashboardNotificationPopupModel(
//         statusCode: json["statusCode"],
//         status: json["status"],
//         message: json["message"],
//         notifications: List<Notification>.from(
//             json["notifications"].map((x) => Notification.fromJson(x))),
//       );

//   Map<String?, dynamic> toJson() => {
//         "statusCode": statusCode,
//         "status": status,
//         "message": message,
//         "notifications":
//             List<dynamic>.from(notifications.map((x) => x.toJson())),
//       };
// }

// class Notification {
//   Notification(
//       {this.notificationId,
//       this.title,
//       this.titleAr,
//       this.description,
//       this.descriptionAr,
//       this.createdOn,
//       this.recordId,
//       this.contractNo,
//       this.fromDate,
//       this.toDate,
//       this.stageId,
//       this.dueActionId,
//       this.showExtend,
//       this.caseId});

//   int notificationId;
//   String? title;
//   String? titleAr;
//   String? description;
//   String? descriptionAr;
//   String? createdOn;
//   int recordId;
//   String? contractNo;
//   String? fromDate;
//   String? toDate;
//   int stageId = 1;
//   int dueActionId;
//   int caseId;
//   bool showExtend;

//   factory Notification.fromJson(Map<String?, dynamic> json) {
//     bool showExtend = true;
//     try {
//       DateTime endDate = DateFormat('dd-MM-yyyy').parse(json["toDate"]);
//       if (DateTime.now().difference(endDate).inDays >= 15) {
//         showExtend = false;
//       }
//     } catch (_) {}
//     return Notification(
//         notificationId: json["notificationId"],
//         title: json["title"],
//         titleAr: json["titleAR"],
//         description: json["description"],
//         descriptionAr: json["descriptionAR"],
//         createdOn: json["createdOn"],
//         recordId: json["recordId"],
//         contractNo: json["contractno"],
//         fromDate: json["fromDate"],
//         toDate: json["toDate"],
//         stageId: json["stageId"],
//         dueActionId: json["stageId"],
//         showExtend: showExtend,
//         caseId: json["caseId"]);
//   }

//   Map<String?, dynamic> toJson() => {
//         "notificationId": notificationId,
//         "title": title,
//         "titleAR": titleAr,
//         "description": description,
//         "descriptionAR": descriptionAr,
//         "createdOn": createdOn,
//       };
// }
