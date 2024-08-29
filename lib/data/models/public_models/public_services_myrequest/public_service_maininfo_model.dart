// To parse this JSON data, do
//
//     final publicServiceMainInfoModel = publicServiceMainInfoModelFromJson(jsonString);

import 'dart:convert';

PublicServiceMainInfoModel publicServiceMainInfoModelFromJson(String? str) =>
    PublicServiceMainInfoModel.fromJson(json.decode(str!));

String? publicServiceMainInfoModelToJson(PublicServiceMainInfoModel data) =>
    json.encode(data.toJson());

class PublicServiceMainInfoModel {
  PublicServiceMainInfoModel({
    this.status,
    this.detail,
    this.caseStatus,
    this.message,
  });

  String? status;
  Detail? detail;
  CaseStatus? caseStatus;
  String? message;

  factory PublicServiceMainInfoModel.fromJson(Map<String?, dynamic> json) =>
      PublicServiceMainInfoModel(
        status: json["status"],
        detail: Detail.fromJson(json["detail"]),
        caseStatus: CaseStatus.fromJson(json["caseStatus"]),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "detail": detail!.toJson(),
        "caseStatus": caseStatus!.toJson(),
        "message": message,
      };
}

class CaseStatus {
  CaseStatus({
    this.canCancel,
    this.canReopen,
    this.canAddFeedback,
    this.requestClosed,
    this.canTakeSurvey,
  });

  bool? canCancel;
  bool? canReopen;
  bool? canAddFeedback;
  bool? requestClosed;
  bool? canTakeSurvey;

  factory CaseStatus.fromJson(Map<String?, dynamic> json) => CaseStatus(
        canCancel: json["canCancel"],
        canReopen: json["canReopen"],
        canAddFeedback: json["canAddFeedback"],
        requestClosed: json["requestClosed"],
        canTakeSurvey: json["canTakeSurvey"],
      );

  Map<String?, dynamic> toJson() => {
        "canCancel": canCancel,
        "canReopen": canReopen,
        "canAddFeedback": canAddFeedback,
        "requestClosed": requestClosed,
        "canTakeSurvey": canTakeSurvey,
      };
}

class Detail {
  Detail(
      {this.caseNo,
      this.caseType,
      this.caseTypeAr,
      this.propertyName,
      this.propertyNameAr,
      this.date,
      this.time,
      this.contactTiming,
      this.category,
      this.subCategory,
      this.unitRefNo,
      this.otherContactPersonName,
      this.otherContactPersonNameAR,
      this.otherContactPersonMobile,
      this.initialAssesment,
      this.initialAssesmentAr,
      this.caseServiceLevel,
      this.caseServiceLevelAr,
      this.description,
      this.descriptionAR,
      this.statusAR,
      this.status,
      this.language,
      this.units,
      this.categoryAR,
      this.categoryAr,
      this.subCategoryAR});

  int? caseNo;
  String? caseType;
  dynamic caseTypeAr;
  String? propertyName;
  String? propertyNameAr;
  String? date;
  String? time;
  String? contactTiming;
  String? category;
  String? subCategory;
  String? unitRefNo;
  String? otherContactPersonName;
  String? otherContactPersonNameAR;
  String? otherContactPersonMobile;
  String? initialAssesment;
  dynamic initialAssesmentAr;
  dynamic caseServiceLevel;
  dynamic caseServiceLevelAr;
  String? description;
  String? descriptionAR;
  dynamic statusAR;
  String? status;
  String? language;
  int? units;
  String? categoryAR;
  String? categoryAr;
  String? subCategoryAR;

  factory Detail.fromJson(Map<String?, dynamic> json) => Detail(
      caseNo: json["caseNo"],
      caseType: json["caseType"],
      caseTypeAr: json["caseTypeAR"],
      propertyName: json["propertyName"],
      propertyNameAr: json["propertyNameAR"],
      date: json["date"],
      time: json["time"],
      contactTiming: json["contactTiming"],
      category: json["category"],
      subCategory: json["subCategory"],
      unitRefNo: json["unitRefNo"],
      otherContactPersonName: json["otherContactPersonName"],
      otherContactPersonNameAR: json["otherContactPersonNameAR"],
      otherContactPersonMobile: json["otherContactPersonMobile"],
      initialAssesment: json["initialAssesment"],
      initialAssesmentAr: json["initialAssesmentAR"],
      caseServiceLevel: json["caseServiceLevel"],
      caseServiceLevelAr: json["caseServiceLevelAR"],
      description: json["description"],
      descriptionAR: json["descriptionAR"],
      statusAR: json["statusAR"],
      status: json["status"],
      language: json["language"],
      units: json["units"],
      categoryAR: json["categoryAR"],
      categoryAr: json["categoryAr"],
      subCategoryAR: '');

  Map<String?, dynamic> toJson() => {
        "caseNo": caseNo,
        "caseType": caseType,
        "caseTypeAR": caseTypeAr,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
        "date": date,
        "time": time,
        "contactTiming": contactTiming,
        "category": category,
        "subCategory": subCategory,
        "unitRefNo": unitRefNo,
        "otherContactPersonName": otherContactPersonName,
        "otherContactPersonNameAR": otherContactPersonNameAR,
        "otherContactPersonMobile": otherContactPersonMobile,
        "initialAssesment": initialAssesment,
        "initialAssesmentAR": initialAssesmentAr,
        "caseServiceLevel": caseServiceLevel,
        "caseServiceLevelAR": caseServiceLevelAr,
        "description": description,
        "descriptionAR": descriptionAR,
        "statusAR": statusAR,
        "status": status,
        "language": language,
        "units": units,
      };
}
