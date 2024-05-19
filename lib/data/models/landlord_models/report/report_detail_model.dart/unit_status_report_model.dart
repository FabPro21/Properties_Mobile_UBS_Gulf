import 'dart:convert';

import 'package:intl/intl.dart';

UnitStatusReportSummaryModel getUnitStatusReportModelFromJson(String str) =>
    UnitStatusReportSummaryModel.fromJson(json.decode(str));

class UnitStatusReportSummaryModel {
  String status;
  int totalRecord;
  List<ServiceRequests> serviceRequests;
  String message;

  UnitStatusReportSummaryModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  UnitStatusReportSummaryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecord = json['totalRecord'];
    if (json['serviceRequests'] != null) {
      serviceRequests = <ServiceRequests>[];
      json['serviceRequests'].forEach((v) {
        serviceRequests.add(new ServiceRequests.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class ServiceRequests {
  String landlordName;
  String landlordNameAR;
  String propertyName;
  String propertyNameAR;
  String emirateName;
  String emirateNameAR;
  String tenantName;
  String tenantNameAR;
  String contractType;
  String contractTypeAR;
  String unitRef;
  String unitStatus;
  String unitStatusAR;
  String unitType;
  String unitTypeAR;
  String unitCategory;
  String unitCategoryAR;
  dynamic rent;
  dynamic annualRent;
  dynamic contractValue;

  ServiceRequests({
    this.landlordName,
    this.landlordNameAR,
    this.propertyName,
    this.propertyNameAR,
    this.emirateName,
    this.emirateNameAR,
    this.tenantName,
    this.tenantNameAR,
    this.contractType,
    this.contractTypeAR,
    this.unitRef,
    this.unitStatus,
    this.unitStatusAR,
    this.unitType,
    this.unitTypeAR,
    this.unitCategory,
    this.unitCategoryAR,
    this.rent,
    this.annualRent,
    this.contractValue,
  });

  ServiceRequests.fromJson(Map<String, dynamic> json) {
    final rentFormat = NumberFormat('#,##0.00', 'AR');
    final annualRentFormat = NumberFormat('#,##0.00', 'AR');
    final contractValueFormate = NumberFormat('#,##0.00', 'AR');

    double rent1 = json['rent'] == 0 || json['rent'] == null
        ? 0
        : json['rent'].roundToDouble();
    double annualRent1 = json['annualRent'] == 0 || json['annualRent'] == null
        ? 0
        : json['annualRent'].roundToDouble();
    double contractValue1 =
        json['contractValue'] == 0 || json['contractValue'] == null
            ? 0
            : json['contractValue'].roundToDouble();

    landlordName = json['landlordName'];
    landlordNameAR = json['landlordNameAR'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    emirateName = json['emirateName'];
    emirateNameAR = json['emirateNameAR'];
    tenantName = json['tenantName'];
    tenantNameAR = json['tenantNameAR'];
    contractType = json['contractType'];
    contractTypeAR = json['contractTypeAR'];
    unitRef = json['unitRef'];
    unitStatus = json['unitStatus'];
    unitStatusAR = json['unitStatusAR'];
    unitType = json['unitType'];
    unitTypeAR = json['unitTypeAR'];
    unitCategory = json['unitCategory'];
    unitCategoryAR = json['unitCategoryAR'];
    rent = rentFormat.format(rent1).toString();
    annualRent = annualRentFormat.format(annualRent1).toString();
    contractValue = contractValueFormate.format(contractValue1).toString();
  }
}
