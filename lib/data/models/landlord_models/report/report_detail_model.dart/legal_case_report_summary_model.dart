import 'dart:convert';

import 'package:intl/intl.dart';

LegalCaseReportSummaryModel getLeglCaseReportModelFromJson(String str) =>
    LegalCaseReportSummaryModel.fromJson(json.decode(str));

class LegalCaseReportSummaryModel {
  String status;
  int totalRecord;
  List<ServiceRequests> serviceRequests;
  String message;

  LegalCaseReportSummaryModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  LegalCaseReportSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String city;
  String cityAR;
  String owner;
  String ownerAR;
  String unitType;
  String unitTypeAR;

  dynamic rent;
  dynamic rentPaidAmount;
  dynamic prevRent;
  dynamic lossofRent;
  int period;
  int lossofRentDays;

  ServiceRequests({
    this.landlordName,
    this.landlordNameAR,
    this.propertyName,
    this.propertyNameAR,
    this.emirateName,
    this.emirateNameAR,
    this.tenantName,
    this.tenantNameAR,
    this.city,
    this.cityAR,
    this.owner,
    this.ownerAR,
    this.unitType,
    this.unitTypeAR,
    this.rent,
    this.rentPaidAmount,
    this.prevRent,
    this.lossofRent,
    this.period,
    this.lossofRentDays,
  });

  ServiceRequests.fromJson(Map<String, dynamic> json) {
    final rentFormat = NumberFormat('#,##0.00', 'AR');
    final rentPaidAmountFormat = NumberFormat('#,##0.00', 'AR');
    final prevRentFormat = NumberFormat('#,##0.00', 'AR');
    final lossofRentFormat = NumberFormat('#,##0.00', 'AR');

    double rent1 =json['rent']==null||json['rent']==0?0: json['rent'].roundToDouble();
    double rentPaidAmount1 = json['prevRent']==null||json['prevRent']==0?0:json['prevRent'].roundToDouble();
    double prevRent1 =json['prevRent']==null||json['prevRent']==0?0 :json['prevRent'].roundToDouble();
    double lossofRent1 = json['paidAmount']==null||json['paidAmount']==0?0:json['paidAmount'].roundToDouble();

    landlordName = json['landlordName'];
    landlordNameAR = json['landlordNameAR'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    emirateName = json['emirateName'];
    emirateNameAR = json['emirateNameAR'];
    tenantName = json['tenantName'];
    tenantNameAR = json['tenantNameAR'];
    city = json['city'];
    cityAR = json['cityAR'];
    owner = json['owner'];
    ownerAR = json['ownerAR'];
    unitType = json['unitType'];
    unitTypeAR = json['unitTypeAR'];
    rent = rentFormat.format(rent1).toString();
    rentPaidAmount = rentPaidAmountFormat.format(rentPaidAmount1).toString();
    prevRent = prevRentFormat.format(prevRent1).toString();
    lossofRent = lossofRentFormat.format(lossofRent1).toString();
    period = json['period'];
    lossofRent = json['lossofRent'];
  }
}
