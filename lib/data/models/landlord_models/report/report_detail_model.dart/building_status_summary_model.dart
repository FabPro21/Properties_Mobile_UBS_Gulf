import 'dart:convert';

import 'package:intl/intl.dart';

BuildingStatusSummaryModel getBuildingStatusSummaryModelFromJson(String? str) =>
    BuildingStatusSummaryModel.fromJson(json.decode(str!));

class BuildingStatusSummaryModel {
  String? status;
  int? totalRecord;
  List<ServiceRequests>? serviceRequests;
  String? message;

  BuildingStatusSummaryModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  BuildingStatusSummaryModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    totalRecord = json['totalRecord'];
    if (json['serviceRequests'] != null) {
      serviceRequests = <ServiceRequests>[];
      json['serviceRequests'].forEach((v) {
        serviceRequests!.add(new ServiceRequests.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class ServiceRequests {
  String? landlordName;
  String? landlordNameAR;
  String? propertyName;
  String? propertyNameAR;
  String? emirateName;
  String? emirateNameAR;
  String? tenantName;
  String? tenantNameAR;
  String? unitType;
  String? unitTypeAR;
  String? unitCategory;
  String? unitCategoryAR;
  String? contractStatus;
  String? contractStatusAR;
  dynamic rent;
  dynamic recived;
  dynamic balance;
  ServiceRequests(
      {this.landlordName,
      this.landlordNameAR,
      this.propertyName,
      this.propertyNameAR,
      this.emirateName,
      this.emirateNameAR,
      this.tenantName,
      this.tenantNameAR,
      this.unitType,
      this.unitTypeAR,
      this.unitCategory,
      this.unitCategoryAR,
      this.contractStatus,
      this.contractStatusAR,
      this.rent,
      this.recived,
      this.balance});

  ServiceRequests.fromJson(Map<String?, dynamic> json) {
    final rentFormat = NumberFormat('#,##0.00', 'AR');
    final recivedFormat = NumberFormat('#,##0.00', 'AR');
    final balanceFormat = NumberFormat('#,##0.00', 'AR');

    double rent1 = json['rent'].roundToDouble();
    double recived1 = json['recived'].roundToDouble();
    double balance1 = json['balance'].roundToDouble();

    landlordName = json['landlordName'];
    landlordNameAR = json['landlordNameAR'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    emirateName = json['emirateName'];
    emirateNameAR = json['emirateNameAR'];
    tenantName = json['tenantName'];
    tenantNameAR = json['tenantNameAR'];
    unitType = json['unitType'];
    unitTypeAR = json['unitTypeAR'];
    unitCategory = json['unitCategory'];
    unitCategoryAR = json['unitCategoryAR'];
    contractStatus = json['contractStatus'];
    contractStatusAR = json['contractStatusAR'];
    rent = rentFormat.format(rent1).toString();
    recived = recivedFormat.format(recived1).toString();
    balance = balanceFormat.format(balance1).toString();
  }
}
