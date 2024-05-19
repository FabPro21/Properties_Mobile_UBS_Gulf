// To parse this JSON data, do
//
//     final landlordContractsModel = landlordContractsModelFromJson(jsonString);

import 'dart:convert';

LandlordContractsModel landlordContractsModelFromJson(String str) =>
    LandlordContractsModel.fromJson(json.decode(str));

String landlordContractsModelToJson(LandlordContractsModel data) =>
    json.encode(data.toJson());

class LandlordContractsModel {
  String status;
  int totalRecord;
  List<Data> data;
  String message;

  LandlordContractsModel(
      {this.status, this.totalRecord, this.data, this.message});

  LandlordContractsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecord = json['totalRecord'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalRecord'] = this.totalRecord;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int contractID;
  String contractno;
  dynamic contractDate;
  String contractStartDate;
  String contractEndDate;
  dynamic rentforstay;
  int noOfDays;
  dynamic gracePeriod;
  dynamic graceStartDate;
  dynamic graceEndDate;
  int noOfContractYears;
  dynamic installments;
  dynamic retention;
  dynamic otherCharges;
  dynamic vatCharges;
  dynamic vatAmount;
  String propertyName;
  String propertyNameAR;
  dynamic propertyImage;
  dynamic unitType;
  dynamic unitTypeAR;
  dynamic unitNo;
  dynamic unitRefNo;
  dynamic total;
  dynamic paid;
  String contractStatus;
  dynamic contractStatusAR;
  int totalRecord;

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

  Data.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contractID'] = this.contractID;
    data['contractno'] = this.contractno;
    data['contractDate'] = this.contractDate;
    data['contractStartDate'] = this.contractStartDate;
    data['contractEndDate'] = this.contractEndDate;
    data['rentforstay'] = this.rentforstay;
    data['noOfDays'] = this.noOfDays;
    data['gracePeriod'] = this.gracePeriod;
    data['graceStartDate'] = this.graceStartDate;
    data['graceEndDate'] = this.graceEndDate;
    data['noOfContractYears'] = this.noOfContractYears;
    data['installments'] = this.installments;
    data['retention'] = this.retention;
    data['otherCharges'] = this.otherCharges;
    data['vatCharges'] = this.vatCharges;
    data['vatAmount'] = this.vatAmount;
    data['propertyName'] = this.propertyName;
    data['propertyNameAR'] = this.propertyNameAR;
    data['propertyImage'] = this.propertyImage;
    data['unitType'] = this.unitType;
    data['unitTypeAR'] = this.unitTypeAR;
    data['unitNo'] = this.unitNo;
    data['unitRefNo'] = this.unitRefNo;
    data['total'] = this.total;
    data['paid'] = this.paid;
    data['contractStatus'] = this.contractStatus;
    data['contractStatusAR'] = this.contractStatusAR;
    data['totalRecord'] = this.totalRecord;
    return data;
  }
}
