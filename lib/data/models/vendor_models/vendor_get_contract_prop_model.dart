// To parse this JSON data, do
//
//     final vendorGetContractPropModel = vendorGetContractPropModelFromJson(jsonString);

import 'dart:convert';

VendorGetContractPropModel vendorGetContractPropModelFromJson(String str) =>
    VendorGetContractPropModel.fromJson(json.decode(str));

String vendorGetContractPropModelToJson(VendorGetContractPropModel data) =>
    json.encode(data.toJson());

class VendorGetContractPropModel {
  VendorGetContractPropModel({
    this.status,
    this.statusCode,
    this.contractProperties,
    this.message,
  });

  String status;
  String statusCode;
  List<ContractProperty> contractProperties;
  String message;

  factory VendorGetContractPropModel.fromJson(Map<String, dynamic> json) =>
      VendorGetContractPropModel(
        status: json["status"],
        statusCode: json["statusCode"],
        contractProperties: List<ContractProperty>.from(
            json["contractProperties"]
                .map((x) => ContractProperty.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "contractProperties":
            List<dynamic>.from(contractProperties.map((x) => x.toJson())),
        "message": message,
      };
}

class ContractProperty {
  ContractProperty({
    this.serviceContractPropertyId,
    this.propertyId,
    this.amount,
    this.propertyImage,
    this.propertyName,
    this.propertyNameAr,
    this.unitType,
    this.unitTypeAr,
  });

  dynamic serviceContractPropertyId;
  dynamic propertyId;
  dynamic amount;
  String propertyImage;
  String propertyName;
  String propertyNameAr;
  String unitType;
  String unitTypeAr;

  factory ContractProperty.fromJson(Map<String, dynamic> json) =>
      ContractProperty(
        serviceContractPropertyId: json["serviceContractPropertyID"],
        propertyId: json["propertyID"],
        amount: json["amount"],
        propertyImage: json["propertyImage"],
        propertyName: json["propertyName"],
        propertyNameAr: json["propertyNameAR"],
        unitType: json["unitType"],
        unitTypeAr: json["unitTypeAR"],
      );

  Map<String, dynamic> toJson() => {
        "serviceContractPropertyID": serviceContractPropertyId,
        "propertyID": propertyId,
        "amount": amount,
        "propertyImage": propertyImage,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
        "unitType": unitType,
        "unitTypeAR": unitTypeAr,
      };
}
