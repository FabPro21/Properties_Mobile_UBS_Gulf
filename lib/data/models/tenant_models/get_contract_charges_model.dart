// To parse this JSON data, do
//
//     final getContractChargesModel = getContractChargesModelFromJson(jsonString);

import 'dart:convert';

GetContractChargesModel getContractChargesModelFromJson(String str) =>
    GetContractChargesModel.fromJson(json.decode(str));

String getContractChargesModelToJson(GetContractChargesModel data) =>
    json.encode(data.toJson());

class GetContractChargesModel {
  GetContractChargesModel({
    this.status,
    this.statusCode,
    this.contractCharges,
    this.totalCharges,
    this.paidCharges,
    this.outstandingCharges,
    this.message,
  });

  String status;
  String statusCode;
  List<ContractCharge> contractCharges;
  dynamic totalCharges;
  dynamic paidCharges;
  dynamic outstandingCharges;
  String message;

  factory GetContractChargesModel.fromJson(Map<String, dynamic> json) =>
      GetContractChargesModel(
        status: json["status"],
        statusCode: json["statusCode"],
        contractCharges: List<ContractCharge>.from(
            json["contractCharges"].map((x) => ContractCharge.fromJson(x))),
        totalCharges: json["totalCharges"],
        paidCharges: json["paidCharges"],
        outstandingCharges: json["outstandingCharges"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "contractCharges":
            List<dynamic>.from(contractCharges.map((x) => x.toJson())),
        "totalCharges": totalCharges,
        "paidCharges": paidCharges,
        "outstandingCharges": outstandingCharges,
        "message": message,
      };
}

class ContractCharge {
  ContractCharge(
      {this.chargeNo,
      this.chargeName,
      this.tenancyCodeNumber,
      this.amount,
      this.contractId,
      this.vatAmount,
      this.totalAmount,
      this.createdOn,
      this.chargesType,
      this.chargesTypeAr,
      this.chargesTypeId});

  dynamic chargeNo;
  String chargeName;
  dynamic tenancyCodeNumber;
  dynamic amount;
  dynamic contractId;
  dynamic vatAmount;
  dynamic totalAmount;
  String createdOn;
  String chargesType;
  String chargesTypeAr;
  int chargesTypeId;

  factory ContractCharge.fromJson(Map<String, dynamic> json) => ContractCharge(
      chargeNo: json["chargeNo"],
      chargeName: json["chargeName"],
      tenancyCodeNumber: json["tenancyCodeNumber"],
      amount: json["amount"],
      contractId: json["contractID"],
      vatAmount: json["vatAmount"],
      totalAmount: json["totalAmount"],
      createdOn: json["createdOn"],
      chargesType: json["chargesType"],
      chargesTypeAr: json["chargesTypeAR"],
      chargesTypeId: json["chargesTypeID"]);

  Map<String, dynamic> toJson() => {
        "chargeNo": chargeNo,
        "chargeName": chargeName,
        "tenancyCodeNumber": tenancyCodeNumber,
        "amount": amount,
        "contractID": contractId,
        "vatAmount": vatAmount,
        "totalAmount": totalAmount,
        "createdOn": createdOn,
        "chargesType": chargesType,
      };
}
