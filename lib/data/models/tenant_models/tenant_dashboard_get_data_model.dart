// To parse this JSON data, do
//
//     final tenantDashboardGetDataModel = tenantDashboardGetDataModelFromJson(jsonString);

import 'dart:convert';

TenantDashboardGetDataModel tenantDashboardGetDataModelFromJson(String str) =>
    TenantDashboardGetDataModel.fromJson(json.decode(str));

class TenantDashboardGetDataModel {
  TenantDashboardGetDataModel(
      {this.status,
      this.dashboard,
      this.statusCode,
      this.message,
      this.unreadNotifications,
      this.contractRenewalAction});

  String status;
  Dashboard dashboard;
  String statusCode;
  String message;
  int unreadNotifications;
  int contractRenewalAction;

  factory TenantDashboardGetDataModel.fromJson(Map<String, dynamic> json) =>
      TenantDashboardGetDataModel(
          status: json["status"],
          dashboard: Dashboard.fromJson(json["dashboard"]),
          statusCode: json["statusCode"],
          message: json["message"],
          unreadNotifications: json["unreadNotifications"],
          contractRenewalAction: json['contractRenewalAction']);
}

class Dashboard {
  Dashboard({
    this.tenantId,
    this.tenantName,
    this.tenantNameAr,
    this.paymentBalance,
    this.contractExpiringIn30Days,
    this.checkDueIn30Days,
    this.rentalVal,
    this.rentOutstanding,
    this.activeContracts,
  });

  dynamic tenantId;
  String tenantName;
  String tenantNameAr;
  dynamic paymentBalance;
  dynamic contractExpiringIn30Days;
  dynamic checkDueIn30Days;
  dynamic rentalVal;
  dynamic rentOutstanding;
  dynamic activeContracts;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        tenantId: json["tenantId"],
        tenantName: json["tenantName"],
        tenantNameAr: json["tenantNameAR"],
        paymentBalance: json["paymentBalance"].toDouble(),
        contractExpiringIn30Days: json["contractExpiringIn30Days"],
        checkDueIn30Days: json["checkDueIn30Days"],
        rentalVal: json["rentalValues"], //rental val
        rentOutstanding: json["rentOutstanding"], // rent outstanding
        activeContracts: json["activeContracts"], //active contracts
      );
}
