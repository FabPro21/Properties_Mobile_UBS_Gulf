// To parse this JSON data, do
//
//     final tenantDashboardGetDataModel = tenantDashboardGetDataModelFromJson(jsonString);

import 'dart:convert';

LandlordDashboardGetDataModel landlordDashboardGetDataModelFromJson(
        String str) =>
    LandlordDashboardGetDataModel.fromJson(json.decode(str));

class LandlordDashboardGetDataModel {
  LandlordDashboardGetDataModel({
    this.status,
    this.dashboard,
    // this.statusCode,
    this.message,
    this.unreadNotifications,
  });

  String status;
  List<Data> dashboard;
  String message;
  String unreadNotifications;

  LandlordDashboardGetDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      dashboard = <Data>[];
      json['data'].forEach((v) {
        dashboard.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    unreadNotifications = json['unreadNotifications'];
  }
}

class Data {
  int occupiedUnits;
  int vacantUnits;
  int totalUnits;
  int activeContracts;
  int openCases;
  int closeCases;
  String landlordName;
  String landlordNameAR;

  Data({
    this.occupiedUnits,
    this.vacantUnits,
    this.totalUnits,
    this.activeContracts,
    this.openCases,
    this.closeCases,
    this.landlordName,
    this.landlordNameAR,
  });

  Data.fromJson(Map<String, dynamic> json) {
    occupiedUnits = json['occupiedUnits'];
    vacantUnits = json['vacantUnits'];
    totalUnits = json['totalUnits'];
    activeContracts = json['activeContracts'];
    openCases = json['contractExpiringIn30Days'];
    closeCases = json['checkDueIn30Days'];
    landlordName = json['landlordName'];
    landlordNameAR = json['landlordNameAR'];
  }
}
