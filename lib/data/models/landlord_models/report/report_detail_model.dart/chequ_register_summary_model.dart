import 'dart:convert';

import 'package:intl/intl.dart';

ChequeRegisterReportSummaryModel getChequeRegisterReportModelFromJson(
        String str) =>
    ChequeRegisterReportSummaryModel.fromJson(json.decode(str));

class ChequeRegisterReportSummaryModel {
  String status;
  int totalRecord;
  List<ServiceRequests> serviceRequests;
  String message;

  ChequeRegisterReportSummaryModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  ChequeRegisterReportSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String chequeStatus;
  String chequeStatusAR;
  String chequeAmount;
  ServiceRequests(
      {this.landlordName,
      this.landlordNameAR,
      this.propertyName,
      this.propertyNameAR,
      this.emirateName,
      this.emirateNameAR,
      this.tenantName,
      this.tenantNameAR,
      this.chequeStatus,
      this.chequeStatusAR,
      this.chequeAmount});

  ServiceRequests.fromJson(Map<String, dynamic> json) {
    final chequeAmountFormat = NumberFormat('#,##0.00', 'AR');
    double chequeAmount1 = json['chequeAmount'].roundToDouble();

    landlordName = json['landlordName'];
    landlordNameAR = json['landlordNameAR'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    emirateName = json['emirateName'];
    emirateNameAR = json['emirateNameAR'];
    tenantName = json['tenantName'];
    tenantNameAR = json['tenantNameAR'];
    chequeStatus = json['chequeStatus'];
    chequeStatusAR = json['chequeStatusAR'];
    chequeAmount = chequeAmountFormat.format(chequeAmount1).toString();
  }
}
