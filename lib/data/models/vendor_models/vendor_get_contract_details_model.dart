// To parse this JSON data, do
//
//     final vendorGetContractDetailsModel = vendorGetContractDetailsModelFromJson(jsonString);

import 'dart:convert';

VendorGetContractDetailsModel vendorGetContractDetailsModelFromJson(
        String? str) =>
    VendorGetContractDetailsModel.fromJson(json.decode(str!));

String? vendorGetContractDetailsModelToJson(
        VendorGetContractDetailsModel data) =>
    json.encode(data.toJson());

class VendorGetContractDetailsModel {
  VendorGetContractDetailsModel({
    this.status,
    this.statusCode,
    this.contractDetail,
    this.message,
  });

  String? status;
  String? statusCode;
  ContractDetail? contractDetail;
  String? message;

  factory VendorGetContractDetailsModel.fromJson(Map<String?, dynamic> json) =>
      VendorGetContractDetailsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        contractDetail: ContractDetail.fromJson(json["contractDetail"]),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "contractDetail": contractDetail!.toJson(),
        "message": message,
      };
}

class ContractDetail {
  ContractDetail({
    this.contractId,
    this.contractNo,
    this.contractDate,
    this.startDate,
    this.endDate,
    this.amount,
    this.contractorId,
    this.contractStatus,
    this.contractStatusAr,
    this.contractLength,
    this.noofStaffswithAccount,
    this.noofStaffswithoutAccount,
    this.paymentInstallments,
    this.paymentTermType,
  });

  int? contractId;
  String? contractNo;
  String? contractDate;
  String? startDate;
  String? endDate;
  dynamic amount;
  int? contractorId;
  String? contractStatus;
  String? contractStatusAr;
  String? contractLength;
  int? noofStaffswithAccount;
  int? noofStaffswithoutAccount;
  int? paymentInstallments;
  String? paymentTermType;

  factory ContractDetail.fromJson(Map<String?, dynamic> json) => ContractDetail(
        contractId: json["contractID"],
        contractNo: json["contractNo"],
        contractDate: json["contractDate"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        amount: json["amount"],
        contractorId: json["contractorID"],
        contractStatus: json["contractStatus"],
        contractStatusAr: json["contractStatusAR"],
        contractLength: json["contractLength"],
        noofStaffswithAccount: json["noofStaffswithAccount"],
        noofStaffswithoutAccount: json["noofStaffswithoutAccount"],
        paymentInstallments: json["paymentInstallments"],
        paymentTermType: json["paymentTermType"],
      );

  Map<String?, dynamic> toJson() => {
        "contractID": contractId,
        "contractNo": contractNo,
        "contractDate": contractDate,
        "startDate": startDate,
        "endDate": endDate,
        "amount": amount,
        "contractorID": contractorId,
        "contractStatus": contractStatus,
        "contractStatusAR": contractStatusAr,
        "contractLength": contractLength,
        "noofStaffswithAccount": noofStaffswithAccount,
        "noofStaffswithoutAccount": noofStaffswithoutAccount,
        "paymentInstallments": paymentInstallments,
        "paymentTermType": paymentTermType,
      };
}
