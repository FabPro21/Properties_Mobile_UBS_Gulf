// To parse this JSON data, do
//
//     final landlordContractsModel = landlordContractsModelFromJson(jsonString);

import 'dart:convert';

LandlordContractsModel landlordContractsModelFromJson(String? str) =>
    LandlordContractsModel.fromJson(json.decode(str!));

String? landlordContractsModelToJson(LandlordContractsModel data) =>
    json.encode(data.toJson());

class LandlordContractsModel {
  String? status;
  int? totalRecord;
  List<Data>? data;
  String? message;

  LandlordContractsModel(
      {this.status, this.totalRecord, this.data, this.message});

  LandlordContractsModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    totalRecord = json['totalRecord'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['status'] = status;
    data['totalRecord'] = totalRecord;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? contractID;
  String? contractno;
  dynamic contractDate;
  String? contractStartDate;
  String? contractEndDate;
  dynamic rentforstay;
  int? noOfDays;
  dynamic gracePeriod;
  dynamic graceStartDate;
  dynamic graceEndDate;
  int? noOfContractYears;
  dynamic installments;
  dynamic retention;
  dynamic otherCharges;
  dynamic vatCharges;
  dynamic vatAmount;
  String? propertyName;
  String? propertyNameAR;
  dynamic propertyImage;
  dynamic unitType;
  dynamic unitTypeAR;
  dynamic unitNo;
  dynamic unitRefNo;
  dynamic total;
  dynamic paid;
  String? contractStatus;
  dynamic contractStatusAR;
  int? totalRecord;

  Data(
      {this.contractID,
      this.contractno,
      this.contractDate,
      this.contractStartDate,
      this.contractEndDate,
      this.rentforstay,
      this.noOfDays,
      this.gracePeriod,
      this.graceStartDate,
      this.graceEndDate,
      this.noOfContractYears,
      this.installments,
      this.retention,
      this.otherCharges,
      this.vatCharges,
      this.vatAmount,
      this.propertyName,
      this.propertyNameAR,
      this.propertyImage,
      this.unitType,
      this.unitTypeAR,
      this.unitNo,
      this.unitRefNo,
      this.total,
      this.paid,
      this.contractStatus,
      this.contractStatusAR,
      this.totalRecord});

  Data.fromJson(Map<String?, dynamic> json) {
    contractID = json['contractID'];
    contractno = json['contractno'];
    contractDate = json['contractDate'];
    contractStartDate = json['contractStartDate'];
    contractEndDate = json['contractEndDate'];
    rentforstay = json['rentforstay'];
    noOfDays = json['noOfDays'];
    gracePeriod = json['gracePeriod'];
    graceStartDate = json['graceStartDate'];
    graceEndDate = json['graceEndDate'];
    noOfContractYears = json['noOfContractYears'];
    installments = json['installments'];
    retention = json['retention'];
    otherCharges = json['otherCharges'];
    vatCharges = json['vatCharges'];
    vatAmount = json['vatAmount'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    propertyImage = json['propertyImage'];
    unitType = json['unitType'];
    unitTypeAR = json['unitTypeAR'];
    unitNo = json['unitNo'];
    unitRefNo = json['unitRefNo'];
    total = json['total'];
    paid = json['paid'];
    contractStatus = json['contractStatus'];
    contractStatusAR = json['contractStatusAR'];
    totalRecord = json['totalRecord'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['contractID'] = contractID;
    data['contractno'] = contractno;
    data['contractDate'] = contractDate;
    data['contractStartDate'] = contractStartDate;
    data['contractEndDate'] = contractEndDate;
    data['rentforstay'] = rentforstay;
    data['noOfDays'] = noOfDays;
    data['gracePeriod'] = gracePeriod;
    data['graceStartDate'] = graceStartDate;
    data['graceEndDate'] = graceEndDate;
    data['noOfContractYears'] = noOfContractYears;
    data['installments'] = installments;
    data['retention'] = retention;
    data['otherCharges'] = otherCharges;
    data['vatCharges'] = vatCharges;
    data['vatAmount'] = vatAmount;
    data['propertyName'] = propertyName;
    data['propertyNameAR'] = propertyNameAR;
    data['propertyImage'] = propertyImage;
    data['unitType'] = unitType;
    data['unitTypeAR'] = unitTypeAR;
    data['unitNo'] = unitNo;
    data['unitRefNo'] = unitRefNo;
    data['total'] = total;
    data['paid'] = paid;
    data['contractStatus'] = contractStatus;
    data['contractStatusAR'] = contractStatusAR;
    data['totalRecord'] = totalRecord;
    return data;
  }
}
