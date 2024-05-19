// To parse this JSON data, do
//
//     final getServiceRequestDetailsModel = getServiceRequestDetailsModelFromJson(jsonString);

import 'dart:convert';

GetServiceRequestDetailsModel getServiceRequestDetailsModelFromJson(
        String str) =>
    GetServiceRequestDetailsModel.fromJson(json.decode(str));

String getServiceRequestDetailsModelToJson(
        GetServiceRequestDetailsModel data) =>
    json.encode(data.toJson());

class GetServiceRequestDetailsModel {
  GetServiceRequestDetailsModel(
      {this.status,
      this.detail,
      this.statusInfo,
      this.message,
      this.contractInfo,
      this.stageInfo});

  String status;
  Detail detail;
  StatusInfo statusInfo;
  String message;
  ContractInfo contractInfo;
  StageInfo stageInfo;

  factory GetServiceRequestDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetServiceRequestDetailsModel(
          status: json["status"],
          detail: Detail.fromJson(json["detail"]),
          statusInfo: StatusInfo.fromJson(json["statusInfo"]),
          message: json["message"],
          contractInfo: ContractInfo.fromJson(json["contractInfo"]),
          stageInfo: StageInfo.fromJson(json["stageInfo"]));

  Map<String, dynamic> toJson() => {
        "status": status,
        "detail": detail.toJson(),
        "message": message,
      };
}

class Detail {
  Detail(
      {this.caseNo,
      this.caseType,
      this.propertyName,
      this.propertyNameAr,
      this.date,
      this.time,
      this.contactTiming,
      this.initialAssesment,
      this.caseServiceLevel,
      this.description,
      this.descriptionAr,
      this.status,
      this.statusAR,
      this.language,
      this.units,
      this.category,
      this.subCategory,
      this.unitRefNo,
      this.contactName,
      this.contactPhone,
      this.caseFeedback,
      this.caseCategouryId,
      this.caseSubCatagouryId,
      this.vacatingDate,
      this.vacatingReason,
      this.categoryAR,
      this.subCategoryAR,
      this.requestType});

  dynamic caseNo;
  String caseType;
  dynamic propertyName;
  dynamic propertyNameAr;
  String date;
  String time;
  String contactTiming;
  String initialAssesment;
  dynamic caseServiceLevel;
  dynamic description;
  dynamic descriptionAr;
  String status;
  String statusAR;
  String language;
  dynamic units;
  String category;
  String subCategory;
  String unitRefNo;
  String contactName;
  String contactPhone;
  int caseFeedback;
  int caseCategouryId;
  int caseSubCatagouryId;
  String vacatingDate;
  String vacatingReason;
  String categoryAR;
  String subCategoryAR;
  String requestType;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
      caseNo: json["caseNo"],
      caseType: json["caseType"],
      propertyName: json["propertyName"],
      propertyNameAr: json["propertyNameAR"],
      date: json["date"],
      time: json["time"],
      contactTiming: json["contactTiming"],
      initialAssesment: json["initialAssesment"],
      caseServiceLevel: json["caseServiceLevel"],
      description: json["description"],
      descriptionAr: json["descriptionAr"],
      status: json["status"],
      statusAR: json["statusAR"],
      language: json["language"],
      units: json["units"],
      category: json["category"],
      subCategory: json["subCategory"],
      unitRefNo: json["unitRefNo"],
      contactName: json["unitRefNoOtherContactPersonName"],
      contactPhone: json["otherContactPersonMobile"],
      caseFeedback: json['caseFeedback'],
      caseCategouryId: json['caseCategouryId'],
      caseSubCatagouryId: json['caseSubCatagouryId'],
      vacatingDate: json["vacatingDate"],
      vacatingReason: json["vacatingReason"],
      categoryAR: json["categoryAR"],
      subCategoryAR: json["subCategoryAR"],
      requestType: json['requestType']);

  Map<String, dynamic> toJson() => {
        "caseNo": caseNo,
        "caseType": caseType,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
        "date": date,
        "time": time,
        "contactTiming": contactTiming,
        "initialAssesment": initialAssesment,
        "caseServiceLevel": caseServiceLevel,
        "description": description,
        "descriptionAr": descriptionAr,
        "status": status,
        "language": language,
        "units": units,
      };
}

class StatusInfo {
  StatusInfo(
      {this.canCancel,
      this.canReopen,
      this.canAddFeedback,
      this.requestClosed,
      this.canTakeSurvey,
      this.canUploadDocs,
      this.showPhotos,
      this.canChat});

  bool canCancel;
  bool canReopen;
  bool canAddFeedback;
  bool requestClosed;
  bool canTakeSurvey;
  bool canUploadDocs;
  bool showPhotos;
  bool canChat;

  factory StatusInfo.fromJson(Map<String, dynamic> json) => StatusInfo(
      canCancel: json["canCancel"],
      canReopen: json["canReopen"],
      canAddFeedback: json["canAddFeedback"],
      requestClosed: json["requestClosed"],
      canTakeSurvey: json["canTakeSurvey"],
      canUploadDocs: json["canUploadDocuments"],
      showPhotos: json["canUploadPhotos"],
      canChat: json["canChat"]);

  Map<String, dynamic> toJson() => {
        "canCancel": canCancel,
        "canReopen": canReopen,
        "canAddFeedback": canAddFeedback,
        "requestClosed": requestClosed,
        "canTakeSurvey": canTakeSurvey,
      };
}

class ContractInfo {
  ContractInfo({
    this.contractno,
    this.contractId,
    this.propertyName,
    this.propertyNameAr,
  });

  String contractno;
  int contractId;
  String propertyName;
  String propertyNameAr;

  factory ContractInfo.fromJson(Map<String, dynamic> json) => ContractInfo(
        contractno: json["contractno"],
        contractId: json["contractID"],
        propertyName: json["propertyName"],
        propertyNameAr: json["propertyNameAR"],
      );

  Map<String, dynamic> toJson() => {
        "contractno": contractno,
        "contractID": contractId,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
      };
}

class StageInfo {
  StageInfo({
    this.dueActionid,
    this.stageId,
  });

  int dueActionid;
  int stageId;

  factory StageInfo.fromJson(Map<String, dynamic> json) => StageInfo(
        dueActionid: json["dueActionid"],
        stageId: json["stageId"],
      );

  Map<String, dynamic> toJson() => {
        "dueActionid": dueActionid,
        "stageId": stageId,
      };
}
