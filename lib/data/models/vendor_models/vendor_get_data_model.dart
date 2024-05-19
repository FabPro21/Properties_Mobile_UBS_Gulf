// To parse this JSON data, do
//
//     final vendorGetDataModel = vendorGetDataModelFromJson(jsonString);

import 'dart:convert';

VendorGetDataModel vendorGetDataModelFromJson(String str) =>
    VendorGetDataModel.fromJson(json.decode(str));

String vendorGetDataModelToJson(VendorGetDataModel data) =>
    json.encode(data.toJson());

class VendorGetDataModel {
  VendorGetDataModel({
    this.statusCode,
    this.status,
    this.message,
    this.dashboard,
    this.unreadNotification,
  });

  String statusCode;
  String status;
  String message;
  Dashboard dashboard;
  int unreadNotification;

  factory VendorGetDataModel.fromJson(Map<String, dynamic> json) =>
      VendorGetDataModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        dashboard: Dashboard.fromJson(json["dashboard"]),
        unreadNotification: json["unreadNotification"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "dashboard": dashboard.toJson(),
        "unreadNotification": unreadNotification,
      };
}

class Dashboard {
  Dashboard(
      {this.name,
      this.company,
      this.companyAr,
      this.nameAr,
      this.paymentInProccess,
      this.invoicesUnderProcess,
      this.lpoInProcess,
      this.totalOpenLpo,
      this.totalOpenServiceRequests,
      this.totalContractValues,
      this.invoiceSubmitted,
      this.totalLpo});

  String name;
  String company;
  String companyAr;
  String nameAr;
  int paymentInProccess;
  int invoicesUnderProcess;
  int lpoInProcess;
  int totalOpenLpo;
  int totalOpenServiceRequests;
  double totalContractValues;
  int invoiceSubmitted;
  int totalLpo;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
      name: json["name"],
      company: json["company"],
      companyAr: json["companyAR"],
      nameAr: json["nameAr"],
      paymentInProccess: json["paymentInProccess"],
      invoicesUnderProcess: json["invoicesUnderProcess"],
      lpoInProcess: json["lpoInProcess"],
      totalOpenLpo: json["totalOpenLpo"],
      totalOpenServiceRequests: json["totalOpenServiceRequests"],
      totalContractValues: json["totalContractValues"].toDouble(),
      invoiceSubmitted: json["invoiceSubmitted"],
      totalLpo: json['totalLpo']);

  Map<String, dynamic> toJson() => {
        "name": name,
        "company": company,
        "nameAr": nameAr,
        "paymentInProccess": paymentInProccess,
        "invoicesUnderProcess": invoicesUnderProcess,
        "lpoInProcess": lpoInProcess,
        "totalOpenLpo": totalOpenLpo,
        "totalOpenServiceRequests": totalOpenServiceRequests,
        "totalContractValues": totalContractValues,
        "invoiceSubmitted": invoiceSubmitted,
      };
}
