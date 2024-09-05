// To parse this JSON data, do
//
//     final getTenantServiceRequestsModel = getTenantServiceRequestsModelFromJson(jsonString);

import 'dart:convert';

GetTenantServiceRequestsModel getTenantServiceRequestsModelFromJson(
        String? str) =>
    GetTenantServiceRequestsModel.fromJson(json.decode(str!));

class GetTenantServiceRequestsModel {
  GetTenantServiceRequestsModel({
    this.status,
    this.serviceRequests,
    this.message,
  });

  String? status;
  List<ServiceRequest>? serviceRequests;
  String? message;

  factory GetTenantServiceRequestsModel.fromJson(Map<String?, dynamic> json) =>
      GetTenantServiceRequestsModel(
        status: json["status"],
        serviceRequests: List<ServiceRequest>.from(
            json["serviceRequests"].map((x) => ServiceRequest.fromJson(x))),
        message: json["message"],
      );
}

class ServiceRequest {
  ServiceRequest(
      {this.requestNo,
      this.category,
      this.categoryAR,
      this.detail,
      this.detailAR,
      this.date,
      this.propertyName,
      this.propertyNameAr,
      this.status,
      this.statusAR,
      this.units,
      this.subCategory,
      this.subCategoryAR,
      this.unitRefNo,
      this.code,
      this.caseType,
      this.dueActionId,
      this.stageId});

  dynamic requestNo;
  String? category;
  String? categoryAR;
  String? detail;
  String? detailAR;
  String? date;
  String? propertyName;
  String? propertyNameAr;
  String? status;
  String? statusAR;
  dynamic units;
  String? subCategory;
  String? subCategoryAR;
  String? unitRefNo;
  int? code;
  String? caseType;
  int? dueActionId;
  int? stageId;

  factory ServiceRequest.fromJson(Map<String?, dynamic> json) => ServiceRequest(
      requestNo: json["requestNo"],
      category: json["category"] ?? '',
      categoryAR: json["categoryAR"] ?? '',
      detail: json["detail"] ?? '',
      detailAR: json["detailAR"] ?? '',
      date: json["date"],
      propertyName: json["propertyName"] ?? '',
      propertyNameAr: json["propertyNameAR"] ?? '',
      status: json["status"] ?? '',
      statusAR: json["statusAR"] ?? '',
      units: json["units"],
      subCategory: json["subCategory"] ?? '',
      subCategoryAR: json["subCategoryAR"] ?? '',
      unitRefNo: json["unitRefNo"],
      code: json["code"],
      caseType: json["caseType"],
      dueActionId: json["dueActionid"] ?? 0,
      stageId: json["stageId"] ?? 0);
}
