import 'dart:convert';

import 'package:intl/intl.dart';

ContractSummaryModel getContractSUmmaryModelFromJson(String? str) =>
    ContractSummaryModel.fromJson(json.decode(str!));

class ContractSummaryModel {
  String? status;
  int? totalRecord;
  List<ServiceRequests>? serviceRequests;
  String? message;

  ContractSummaryModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  ContractSummaryModel.fromJson(Map<String?, dynamic> json) {
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
  String? contractno;
  String? propertyName;
  String? propertyNameAR;
  String? contractStatus;
  String? contractStatusAR;
  dynamic vATCharges;
  dynamic vATAmount;
  dynamic total;
  dynamic paid;
  ServiceRequests(
      {this.contractno,
      this.propertyName,
      this.propertyNameAR,
      this.contractStatus,
      this.contractStatusAR,
      this.vATCharges,
      this.vATAmount,
      this.total,
      this.paid});

  ServiceRequests.fromJson(Map<String?, dynamic> json) {
    final vATChargesFormat = NumberFormat('#,##0.00', 'AR');
    final vATAmountFormat = NumberFormat('#,##0.00', 'AR');
    final totalFormat = NumberFormat('#,##0.00', 'AR');
    final paidFormat = NumberFormat('#,##0.00', 'AR');

    double vATCharges1 = json['vatCharges'].roundToDouble();
    double vATAmount1 = json['vatAmount'].roundToDouble();
    double total1 = json['total'].roundToDouble();
    double paid1 = json['paid'].roundToDouble();

    contractno = json['contractno'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    contractStatus = json['contractStatus'];
    contractStatusAR = json['contractStatusAR'];
    vATCharges = vATChargesFormat.format(vATCharges1).toString();
    vATAmount = vATAmountFormat.format(vATAmount1).toString();
    total = totalFormat.format(total1).toString();
    paid = paidFormat.format(paid1).toString();
  }
}
