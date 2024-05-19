// To parse this JSON data, do
//
//     final getContractsModel = getContractsModelFromJson(jsonString);

import 'dart:convert';

GetContractsModel getContractsModelFromJson(String str) =>
    GetContractsModel.fromJson(json.decode(str));

String getContractsModelToJson(GetContractsModel data) =>
    json.encode(data.toJson());

class GetContractsModel {
  GetContractsModel({
    this.status,
    this.contracts,
    this.message,
  });

  String status;
  List<Contract> contracts;
  String message;

  factory GetContractsModel.fromJson(Map<String, dynamic> json) =>
      GetContractsModel(
        status: json["status"],
        contracts: List<Contract>.from(
            json["contracts"].map((x) => Contract.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "contracts": List<dynamic>.from(contracts.map((x) => x.toJson())),
        "message": message,
      };
}

class Contract {
  Contract({
    this.contractId,
    this.contractStatusId,
    this.propertyTypeId,
    this.propertyStatusId,
    this.contractno,
    this.previousContactNo,
    this.address,
    this.addressAr,
    this.emirateName,
    this.contractDate,
    this.contractStartDate,
    this.contractStatusAr,
    this.contractEndDate,
    this.rentforstay,
    this.noOfDays,
    this.gracePeriod,
    this.noOfContractYears,
    this.installments,
    this.retention,
    this.otherCharges,
    this.vatCharges,
    this.vatAmount,
    this.propertyName,
    this.propertyNameAr,
    this.propertyImage,
    this.unitType,
    this.unitTypeAr,
    this.unitNo,
    this.total,
    this.paid,
    this.unitRefNo,
    this.contractStatus,
  });

  dynamic contractId;
  dynamic contractStatusId;
  dynamic propertyTypeId;
  dynamic propertyStatusId;
  String contractno;
  String previousContactNo;
  dynamic address;
  dynamic addressAr;
  dynamic emirateName;
  String contractDate;
  String contractStartDate;
  String contractStatusAr;
  String contractEndDate;
  dynamic rentforstay;
  dynamic noOfDays;
  dynamic gracePeriod;
  dynamic noOfContractYears;
  dynamic installments;
  String retention;
  dynamic otherCharges;
  dynamic vatCharges;
  dynamic vatAmount;
  String propertyName;
  String propertyNameAr;
  String propertyImage;
  String unitType;
  dynamic unitTypeAr;
  String unitNo;
  dynamic total;
  dynamic paid;
  dynamic unitRefNo;
  String contractStatus;

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        contractId: json["contractID"],
        contractStatusId: json["contractStatusID"],
        propertyTypeId: json["propertyTypeID"],
        propertyStatusId: json["propertyStatusID"],
        contractno: json["contractno"],
        previousContactNo: json["previousContactNo"],
        address: json["address"],
        addressAr: json["addressAR"],
        emirateName: json["emirateName"],
        contractDate: json["contractDate"],
        contractStartDate: json["contractStartDate"],
        contractStatusAr: json["contractStatusAR"] ?? '',
        contractEndDate: json["contractEndDate"],
        rentforstay: json["rentforstay"],
        noOfDays: json["noOfDays"],
        gracePeriod: json["gracePeriod"],
        noOfContractYears: json["noOfContractYears"],
        installments: json["installments"],
        retention: json["retention"],
        otherCharges: json["otherCharges"],
        vatCharges: json["vatCharges"],
        vatAmount: json["vatAmount"],
        propertyName: json["propertyName"] ?? '',
        propertyNameAr: json["propertyNameAR"] ?? '',
        propertyImage: json["propertyImage"],
        unitType: json["unitType"],
        unitTypeAr: json["unitTypeAR"],
        unitNo: json["unitNo"],
        total: json["total"],
        paid: json["paid"],
        unitRefNo: json["unitRefNo"],
        contractStatus: json["contractStatus"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "contractID": contractId,
        "contractStatusID": contractStatusId,
        "propertyTypeID": propertyTypeId,
        "propertyStatusID": propertyStatusId,
        "contractno": contractno,
        "address": address,
        "addressAR": addressAr,
        "emirateName": emirateName,
        "contractDate": contractDate,
        "contractStartDate": contractStartDate,
        "contractStatusAR": contractStatusAr,
        "contractEndDate": contractEndDate,
        "rentforstay": rentforstay,
        "noOfDays": noOfDays,
        "gracePeriod": gracePeriod,
        "noOfContractYears": noOfContractYears,
        "installments": installments,
        "retention": retention,
        "otherCharges": otherCharges,
        "vatCharges": vatCharges,
        "vatAmount": vatAmount,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
        "propertyImage": propertyImage,
        "unitType": unitType,
        "unitTypeAR": unitTypeAr,
        "unitNo": unitNo,
        "total": total,
        "paid": paid,
        "unitRefNo": unitRefNo,
        "contractStatus": contractStatus,
      };
}
