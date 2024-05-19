// To parse this JSON data, do
//
//     final getContractStatusModel = getContractStatusModelFromJson(jsonString);

import 'dart:convert';

GetContractStatusModel getContractStatusModelFromJson(String str) =>
    GetContractStatusModel.fromJson(json.decode(str));

String getContractStatusModelToJson(GetContractStatusModel data) =>
    json.encode(data.toJson());

class GetContractStatusModel {
  GetContractStatusModel({
    this.status,
    this.statusCode,
    this.contractStatus,
    this.message,
  });

  String status;
  String statusCode;
  List<ContractStatus> contractStatus;
  String message;

  factory GetContractStatusModel.fromJson(Map<String, dynamic> json) =>
      GetContractStatusModel(
        status: json["status"],
        statusCode: json["statusCode"],
        contractStatus: List<ContractStatus>.from(
            json["contractStatus"].map((x) => ContractStatus.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "contractStatus":
            List<dynamic>.from(contractStatus.map((x) => x.toJson())),
        "message": message,
      };
}

class ContractStatus {
  ContractStatus({
    this.contractTypeId,
    this.contractType,
    this.contractTypeAr,
  });

  int contractTypeId;
  String contractType;
  String contractTypeAr;

  factory ContractStatus.fromJson(Map<String, dynamic> json) => ContractStatus(
        contractTypeId: json["contractTypeID"],
        contractType: json["contractType"],
        contractTypeAr: json["contractTypeAR"],
      );

  Map<String, dynamic> toJson() => {
        "contractTypeID": contractTypeId,
        "contractType": contractType,
        "contractTypeAR": contractTypeAr,
      };
}
