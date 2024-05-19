import 'dart:convert';

import 'package:intl/intl.dart';

AMCReportSummaryModel getAMCReportSUmmaryModelFromJson(String str) =>
    AMCReportSummaryModel.fromJson(json.decode(str));

class AMCReportSummaryModel {
  String status;
  int totalRecord;
  List<ServiceRequests> serviceRequests;
  String message;

  AMCReportSummaryModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  AMCReportSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String ownerName;
  String ownerNameAR;
  String propertyName;
  String propertyNameAR;
  String contractCategory;
  String contractCategoryAR;
  String contractor;
  String contractorAR;
  dynamic contractTotalAmount;
  dynamic contractValueUnPaid;
  dynamic contractAnnualAmount;
  dynamic paidAmount;
  dynamic balance;
  ServiceRequests(
      {this.ownerName,
      this.ownerNameAR,
      this.propertyName,
      this.propertyNameAR,
      this.contractCategory,
      this.contractCategoryAR,
      this.contractor,
      this.contractorAR,
      this.contractTotalAmount,
      this.contractValueUnPaid,
      this.contractAnnualAmount,
      this.paidAmount,
      this.balance});

  ServiceRequests.fromJson(Map<String, dynamic> json) {
    final contractTotalAmountFormat = NumberFormat('#,##0.00', 'AR');
    final contractValueUnPaidFormat = NumberFormat('#,##0.00', 'AR');
    final contractAnnualAmountFormat = NumberFormat('#,##0.00', 'AR');
    final paidAmountFormat = NumberFormat('#,##0.00', 'AR');
    final balanceFormat = NumberFormat('#,##0.00', 'AR');

    double contractTotalAmount1 = json['contractTotalAmount'].roundToDouble();
    double contractValueUnPaid1 = json['contractValueUnPaid'].roundToDouble();
    double contractAnnualAmount1 = json['contractAnnualAmount'].roundToDouble();
    double paidAmount1 = json['paidAmount'].roundToDouble();
    double balance1 = json['balance'].roundToDouble();

    ownerNameAR = json['ownerNameAR'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    contractCategory = json['contractCategory'];
    contractCategoryAR = json['contractCategoryAR'];
    contractor = json['contractor'];
    contractorAR = json['contractorAR'];
    contractTotalAmount =
        contractTotalAmountFormat.format(contractTotalAmount1).toString();
    contractValueUnPaid =
        contractValueUnPaidFormat.format(contractValueUnPaid1).toString();
    contractAnnualAmount =
        contractAnnualAmountFormat.format(contractAnnualAmount1).toString();
    paidAmount = paidAmountFormat.format(paidAmount1).toString();
    balance = balanceFormat.format(balance1).toString();
  }
}
