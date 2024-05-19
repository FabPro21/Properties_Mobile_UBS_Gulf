import 'dart:convert';

import 'package:intl/intl.dart';

ReceipRegisterReportSummaryModel getReceiptRegisterReportModelFromJson(
        String str) =>
    ReceipRegisterReportSummaryModel.fromJson(json.decode(str));

class ReceipRegisterReportSummaryModel {
  String status;
  int totalRecord;
  List<ServiceRequests> serviceRequests;
  String message;

  ReceipRegisterReportSummaryModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  ReceipRegisterReportSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String unitType;
  String unitTypeAR;
  String modeofPayment;
  String modeofPaymentAR;
  dynamic totalAmount;
  dynamic cardCharges;
  dynamic netAmount;

  ServiceRequests({
    this.landlordName,
    this.landlordNameAR,
    this.propertyName,
    this.propertyNameAR,
    this.emirateName,
    this.emirateNameAR,
    this.tenantName,
    this.tenantNameAR,
    this.unitType,
    this.unitTypeAR,
    this.modeofPayment,
    this.modeofPaymentAR,
    this.totalAmount,
    this.cardCharges,
    this.netAmount,
  });

  ServiceRequests.fromJson(Map<String, dynamic> json) {
    final totalAmountFormat = NumberFormat('#,##0.00', 'AR');
    final cardChargesFormat = NumberFormat('#,##0.00', 'AR');
    final netAmountFormat = NumberFormat('#,##0.00', 'AR');

    double totalAmount1 = json['totalAmount'].roundToDouble();
    double cardCharges1 = json['cardCharges'].roundToDouble();
    double netAmount1 = json['netAmount'].roundToDouble();

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
    modeofPayment = json['modeofPayment'];
    modeofPaymentAR = json['modeofPaymentAR'];
    totalAmount = totalAmountFormat.format(totalAmount1).toString();
    cardCharges = cardChargesFormat.format(cardCharges1).toString();
    netAmount = netAmountFormat.format(netAmount1).toString();
  }
}
