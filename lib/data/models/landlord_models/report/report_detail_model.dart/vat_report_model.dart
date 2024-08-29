import 'dart:convert';

import 'package:intl/intl.dart';

VATReportSummaryModel getVATReportSummaryModelFromJson(String? str) =>
    VATReportSummaryModel.fromJson(json.decode(str!));

class VATReportSummaryModel {
  String? status;
  int? totalRecord;
  List<ServiceRequests>? serviceRequests;
  String? message;

  VATReportSummaryModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  VATReportSummaryModel.fromJson(Map<String?, dynamic> json) {
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
  String? contractType;
  String? contractTypeAR;
  dynamic vATCharges;
  dynamic invoicedAmount;
  dynamic vATPaidAmt;

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
    this.vATCharges,
    this.invoicedAmount,
    this.vATPaidAmt,
  });

  ServiceRequests.fromJson(Map<String?, dynamic> json) {
    final vATChargesFormat = NumberFormat('#,##0.00', 'AR');
    final invoicedAmountFormat = NumberFormat('#,##0.00', 'AR');
    final vATPaidAmtFormat = NumberFormat('#,##0.00', 'AR');

    double vATCharges1 = json['vatCharges'] == '' || json['vatCharges'] == 0
        ? 0
        : json['invoicedAmount'].roundToDouble();
    double invoicedAmount1 =
        json['invoicedAmount'] == '' || json['invoicedAmount'] == 0
            ? 0
            : json['invoicedAmount'].roundToDouble();
    double vATPaidAmt1 = json['vatPaidAmt'] == '' || json['vatPaidAmt'] == 0
        ? 0
        : json['vatPaidAmt'].roundToDouble();

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
    vATCharges = vATChargesFormat.format(vATCharges1).toString();
    invoicedAmount = invoicedAmountFormat.format(invoicedAmount1).toString();
    vATPaidAmt = vATPaidAmtFormat.format(vATPaidAmt1).toString();
  }
}
