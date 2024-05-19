// To parse this JSON data, do
//
//     final getVendorServiceRequestDetailsModel = getVendorServiceRequestDetailsModelFromJson(jsonString);

import 'dart:convert';

GetVendorServiceRequestDetailsModel getVendorServiceRequestDetailsModelFromJson(
        String str) =>
    GetVendorServiceRequestDetailsModel.fromJson(json.decode(str));

String getVendorServiceRequestDetailsModelToJson(
        GetVendorServiceRequestDetailsModel data) =>
    json.encode(data.toJson());

class GetVendorServiceRequestDetailsModel {
  GetVendorServiceRequestDetailsModel({
    this.status,
    this.statusAR,
    this.detail,
    this.statusInfo,
    this.message,
  });

  String status;
  String statusAR;
  Detail detail;
  StatusInfo statusInfo;
  String message;

  factory GetVendorServiceRequestDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      GetVendorServiceRequestDetailsModel(
        status: json["status"],
        statusAR: json["statusAR"],
        detail: Detail.fromJson(json["detail"]),
        statusInfo: StatusInfo.fromJson(json['statusInfo']),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusAR": statusAR,
        "detail": detail.toJson(),
        "message": message,
      };
}

class Detail {
  Detail(
      {this.caseNo,
      this.caseType,
      this.propertyName,
      this.date,
      this.time,
      this.contactTiming,
      this.contactName,
      this.contactPhone,
      this.otherContactName,
      this.otherContactPhone,
      this.initialAssesment,
      this.caseServiceLevel,
      this.propertyNameAr,
      this.description,
      this.status,
      this.statusAR,
      this.language,
      this.units,
      this.category,
      this.categoryAR,
      this.subCategory,
      this.subcategoryAR,
      this.unitRefNo,
      this.contractorAcknowledged,
      this.contractorRejected});

  int caseNo;
  String caseType;
  String propertyName;
  String propertyNameAr;
  String date;
  String time;
  String contactTiming;
  String contactName;
  String contactPhone;
  String otherContactName;
  String otherContactPhone;
  String initialAssesment;
  String caseServiceLevel;
  String description;
  String status;
  String statusAR;
  String language;
  int units;
  String category;
  String categoryAR;
  String subCategory;
  String subcategoryAR;
  String unitRefNo;
  bool contractorAcknowledged;
  bool contractorRejected;

  factory Detail.fromJson(Map<String, dynamic> json) {
    String otherContactName = json["contactPersonName"];
    String otherContactPhone = json["contactPersonMobile"];
    if (otherContactName == '') otherContactName = null;
    if (otherContactPhone == '') otherContactPhone = null;
    return Detail(
        caseNo: json["caseNo"],
        caseType: json["caseType"],
        propertyName: json["propertyName"],
        propertyNameAr: json["propertyNameAR"],
        date: json["date"],
        time: json["time"],
        contactTiming: json["contactTiming"],
        contactName: json["otherContactPersonName"],
        contactPhone: json["otherContactPersonMobile"],
        otherContactName: otherContactName,
        otherContactPhone: otherContactPhone,
        initialAssesment: json["initialAssesment"],
        caseServiceLevel: json["caseServiceLevel"],
        description: json["description"],
        status: json["status"],
        statusAR: json["statusAR"],
        language: json["language"],
        units: json["units"],
        category: json["category"],
        categoryAR: json["categoryAR"],
        subCategory: json["subcategory"],
        subcategoryAR: json["subcategoryAR"],
        unitRefNo: json["unitRefNo"],
        contractorAcknowledged: json["contractorAcknowledged"],
        contractorRejected: json["contractorRejected"]);
  }

  Map<String, dynamic> toJson() => {
        "caseNo": caseNo,
        "caseType": caseType,
        "propertyName": propertyName,
        "date": date,
        "time": time,
        "contactTiming": contactTiming,
        "initialAssesment": initialAssesment,
        "caseServiceLevel": caseServiceLevel,
        "description": description,
        "status": status,
        "statusAR": statusAR,
        "language": language,
        "units": units,
      };
}

class StatusInfo {
  StatusInfo({
    this.requestClosed,
    this.canClose,
  });

  bool requestClosed;
  bool canClose;

  factory StatusInfo.fromJson(Map<String, dynamic> json) => StatusInfo(
        requestClosed: json["requestClosed"],
        canClose: json["canClose"],
      );

  Map<String, dynamic> toJson() => {
        "requestClosed": requestClosed,
        "canClose": canClose,
      };
}
