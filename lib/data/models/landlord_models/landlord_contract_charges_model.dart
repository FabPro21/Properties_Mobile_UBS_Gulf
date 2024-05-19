// To parse this JSON data, do
//
//     final landlordContractChargesModel = landlordContractChargesModelFromJson(jsonString);

import 'dart:convert';

LandlordContractChargesModel landlordContractChargesModelFromJson(String str) =>
    LandlordContractChargesModel.fromJson(json.decode(str));

String landlordContractChargesModelToJson(LandlordContractChargesModel data) =>
    json.encode(data.toJson());

class LandlordContractChargesModel {
  LandlordContractChargesModel({
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
  int totalCharges;
  int paidCharges;
  int outstandingCharges;
  String message;

  factory LandlordContractChargesModel.fromJson(Map<String, dynamic> json) =>
      LandlordContractChargesModel(
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
  ContractCharge({
    this.chargeNo,
    this.chargesTypeId,
    this.chargeName,
    this.tenancyCodeNumber,
    this.amount,
    this.contractId,
    this.vatAmount,
    this.totalAmount,
    this.createdOn,
    this.chargesType,
    this.chargesTypeAr,
  });

  int chargeNo;
  int chargesTypeId;
  String chargeName;
  int tenancyCodeNumber;
  int amount;
  int contractId;
  int vatAmount;
  int totalAmount;
  String createdOn;
  String chargesType;
  dynamic chargesTypeAr;

  factory ContractCharge.fromJson(Map<String, dynamic> json) => ContractCharge(
        chargeNo: json["chargeNo"],
        chargesTypeId: json["chargesTypeID"],
        chargeName: json["chargeName"],
        tenancyCodeNumber: json["tenancyCodeNumber"],
        amount: json["amount"],
        contractId: json["contractID"],
        vatAmount: json["vatAmount"],
        totalAmount: json["totalAmount"],
        createdOn: json["createdOn"],
        chargesType: json["chargesType"],
        chargesTypeAr: json["chargesTypeAR"],
      );

  Map<String, dynamic> toJson() => {
        "chargeNo": chargeNo,
        "chargesTypeID": chargesTypeId,
        "chargeName": chargeName,
        "tenancyCodeNumber": tenancyCodeNumber,
        "amount": amount,
        "contractID": contractId,
        "vatAmount": vatAmount,
        "totalAmount": totalAmount,
        "createdOn": createdOn,
        "chargesType": chargesType,
        "chargesTypeAR": chargesTypeAr,
      };
}
