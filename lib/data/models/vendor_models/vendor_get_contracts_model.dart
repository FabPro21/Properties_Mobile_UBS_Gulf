// To parse this JSON data, do
//
//     final vendorContractsModel = vendorContractsModelFromJson(jsonString);

import 'dart:convert';

VendorContractsModel vendorContractsModelFromJson(String str) =>
    VendorContractsModel.fromJson(json.decode(str));

String vendorContractsModelToJson(VendorContractsModel data) =>
    json.encode(data.toJson());

class VendorContractsModel {
  VendorContractsModel({
    this.status,
    this.statusCode,
    this.contracts,
    this.message,
  });

  String status;
  String statusCode;
  List<Contract> contracts;
  String message;

  factory VendorContractsModel.fromJson(Map<String, dynamic> json) =>
      VendorContractsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        contracts: List<Contract>.from(
            json["contracts"].map((x) => Contract.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "contracts": List<dynamic>.from(contracts.map((x) => x.toJson())),
        "message": message,
      };
}

class Contract {
  Contract({
    this.contractId,
    this.contractNo,
    this.contractDate,
    this.startDate,
    this.endDate,
    this.amount,
    this.contractorId,
    this.contractStatusId,
    this.contractStatus,
    this.contractStatusAr,
    this.propertyName,
    this.propertyNameAR,
  });

  dynamic contractId;
  String contractNo;
  String contractDate;
  String startDate;
  String endDate;
  dynamic amount;
  dynamic contractorId;
  dynamic contractStatusId;
  String contractStatus;
  String contractStatusAr;
  String propertyName;
  String propertyNameAR;

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        contractId: json["contractID"],
        contractNo: json["contractNo"],
        contractDate: json["contractDate"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        amount: json["amount"],
        contractorId: json["contractorID"],
        contractStatusId: json["contractStatusID"],
        contractStatus: json["contractStatus"] ?? '',
        contractStatusAr: json["contractStatusAR"] ?? '',
        propertyName: json["propertyName"] ?? '',
        propertyNameAR: json["propertyNameAR"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "contractID": contractId,
        "contractNo": contractNo,
        "contractDate": contractDate,
        "startDate": startDate,
        "endDate": endDate,
        "amount": amount,
        "contractorID": contractorId,
        "contractStatusID": contractStatusId,
        "contractStatus": contractStatus,
        "contractStatusAR": contractStatusAr,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAR,
      };
}
