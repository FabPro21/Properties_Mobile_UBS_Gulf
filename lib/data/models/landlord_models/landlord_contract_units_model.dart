// To parse this JSON data, do
//
//     final landlordContractUnitsModel = landlordContractUnitsModelFromJson(jsonString);

import 'dart:convert';

LandlordContractUnitsModel landlordContractUnitsModelFromJson(String str) =>
    LandlordContractUnitsModel.fromJson(json.decode(str));

String landlordContractUnitsModelToJson(LandlordContractUnitsModel data) =>
    json.encode(data.toJson());

class LandlordContractUnitsModel {
  LandlordContractUnitsModel({
    this.status,
    this.statusCode,
    this.contractUnits,
    this.message,
  });

  String status;
  String statusCode;
  List<ContractUnit> contractUnits;
  String message;

  factory LandlordContractUnitsModel.fromJson(Map<String, dynamic> json) =>
      LandlordContractUnitsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        contractUnits: List<ContractUnit>.from(
            json["contractUnits"].map((x) => ContractUnit.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "contractUnits":
            List<dynamic>.from(contractUnits.map((x) => x.toJson())),
        "message": message,
      };
}

class ContractUnit {
  ContractUnit({
    this.propertyImage,
    this.propertyName,
    this.propertyNameAr,
    this.amount,
    this.unitRefNo,
    this.unitId,
    this.propertyType,
    this.propertyTypeAr,
    this.unitType,
    this.unitTypeAr,
  });

  String propertyImage;
  String propertyName;
  String propertyNameAr;
  double amount;
  String unitRefNo;
  int unitId;
  String propertyType;
  String propertyTypeAr;
  String unitType;
  dynamic unitTypeAr;

  factory ContractUnit.fromJson(Map<String, dynamic> json) => ContractUnit(
        propertyImage: json["propertyImage"],
        propertyName: json["propertyName"],
        propertyNameAr: json["propertyNameAR"],
        amount: json["amount"],
        unitRefNo: json["unitRefNo"],
        unitId: json["unitID"],
        propertyType: json["propertyType"],
        propertyTypeAr: json["propertyTypeAR"],
        unitType: json["unitType"],
        unitTypeAr: json["unitTypeAR"],
      );

  Map<String, dynamic> toJson() => {
        "propertyImage": propertyImage,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
        "amount": amount,
        "unitRefNo": unitRefNo,
        "unitID": unitId,
        "propertyType": propertyType,
        "propertyTypeAR": propertyTypeAr,
        "unitType": unitType,
        "unitTypeAR": unitTypeAr,
      };
}
