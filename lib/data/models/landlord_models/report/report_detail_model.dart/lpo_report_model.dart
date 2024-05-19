import 'dart:convert';

import 'package:intl/intl.dart';

LpoReportSummaryModel getLpoReportSummaryModelFromJson(String str) =>
    LpoReportSummaryModel.fromJson(json.decode(str));

class LpoReportSummaryModel {
  String status;
  int totalRecord;
  List<ServiceRequests> serviceRequests;
  String message;

  LpoReportSummaryModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  LpoReportSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String lpoType;
  String lpoTypeAR;
  String contractor;
  String contractorAR;
  String lpoStatus;
  String lpoStatusAR;
  String lpoTitle;
  String lpoTitleAR;
  dynamic propertiesAmount;
  dynamic totalAmount;
  dynamic netAmount;
  dynamic recoveryAmount;

  ServiceRequests({
    this.landlordName,
    this.landlordNameAR,
    this.propertyName,
    this.propertyNameAR,
    this.emirateName,
    this.emirateNameAR,
    this.tenantName,
    this.tenantNameAR,
    this.lpoTitle,
    this.lpoTitleAR,
    this.lpoType,
    this.lpoTypeAR,
    this.contractor,
    this.contractorAR,
    this.lpoStatus,
    this.lpoStatusAR,
    this.propertiesAmount,
    this.totalAmount,
    this.netAmount,
    this.recoveryAmount,
  });

  ServiceRequests.fromJson(Map<String, dynamic> json) {
    final propertiesAmountFormat = NumberFormat('#,##0.00', 'AR');
    final totalAmountFormat = NumberFormat('#,##0.00', 'AR');
    final netAmountFormat = NumberFormat('#,##0.00', 'AR');
    final recoveryAmountFormat = NumberFormat('#,##0.00', 'AR');

    double propertiesAmount1 = json['propertiesAmount'].roundToDouble();
    double totalAmount1 = json['totalAmount'].roundToDouble();
    double netAmount1 = json['netAmount'].roundToDouble();
    double recoveryAmount1 = json['recoveryAmount'].roundToDouble();

    landlordName = json['landlordName'];
    landlordNameAR = json['landlordNameAR'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    emirateName = json['emirateName'];
    emirateNameAR = json['emirateNameAR'];
    tenantName = json['tenantName'];
    tenantNameAR = json['tenantNameAR'];
    lpoType = json['lpoType'];
    lpoTypeAR = json['lpoTypeAR'];
    contractor = json['contractor'];
    contractorAR = json['contractorAR'];
    lpoStatus = json['lpoStatus'];
    lpoStatusAR = json['lpoStatusAR'];
    lpoTitle = json['lpoTitle'];
    lpoTitleAR = json['lpoTitleAR'];
    propertiesAmount =
        propertiesAmountFormat.format(propertiesAmount1).toString();
    totalAmount = totalAmountFormat.format(totalAmount1).toString();
    netAmount = netAmountFormat.format(netAmount1).toString();
    recoveryAmount = recoveryAmountFormat.format(recoveryAmount1).toString();
  }
}
