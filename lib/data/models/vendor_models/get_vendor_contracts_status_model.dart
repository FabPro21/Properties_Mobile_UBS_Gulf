// To parse this JSON data, do
//
//     final getVendorContractsStatusModel = getVendorContractsStatusModelFromJson(jsonString);

import 'dart:convert';

GetVendorContractsStatusModel getVendorContractsStatusModelFromJson(
        String? str) =>
    GetVendorContractsStatusModel.fromJson(json.decode(str!));

String? getVendorContractsStatusModelToJson(
        GetVendorContractsStatusModel data) =>
    json.encode(data.toJson());

class GetVendorContractsStatusModel {
  GetVendorContractsStatusModel({
    this.status,
    this.statusCode,
    this.contractStatus,
    this.message,
  });

  String? status;
  String? statusCode;
  List<VendorContractStatus>? contractStatus;
  String? message;

  factory GetVendorContractsStatusModel.fromJson(Map<String?, dynamic> json) =>
      GetVendorContractsStatusModel(
        status: json["status"],
        statusCode: json["statusCode"],
        contractStatus: List<VendorContractStatus>.from(json["contractStatus"]
            .map((x) => VendorContractStatus.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "contractStatus":
            List<dynamic>.from(contractStatus!.map((x) => x.toJson())),
        "message": message,
      };
}

class VendorContractStatus {
  VendorContractStatus({
    this.serviceContractStatusId,
    this.statusName,
    this.statusNameAr,
  });

  dynamic serviceContractStatusId;
  String? statusName;
  String? statusNameAr;

  factory VendorContractStatus.fromJson(Map<String?, dynamic> json) =>
      VendorContractStatus(
        serviceContractStatusId: json["serviceContractStatusID"],
        statusName: json["statusName"],
        statusNameAr: json["statusNameAr"],
      );

  Map<String?, dynamic> toJson() => {
        "serviceContractStatusID": serviceContractStatusId,
        "statusName": statusName,
        "statusNameAr": statusNameAr,
      };
}

class VendorContractFilterData {
  final String? propName;
  final dynamic contractStatusId;
  final String? fromDate;
  final String? toDate;

  VendorContractFilterData(
      {this.propName, this.contractStatusId, this.fromDate, this.toDate});
}
