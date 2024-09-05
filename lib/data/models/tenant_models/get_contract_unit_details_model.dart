// To parse this JSON data, do
//
//     final getContractUnitDetailsModel = getContractUnitDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

GetContractUnitDetailsModel getContractUnitDetailsModelFromJson(String? str) =>
    GetContractUnitDetailsModel.fromJson(json.decode(str!));

String? getContractUnitDetailsModelToJson(GetContractUnitDetailsModel data) =>
    json.encode(data.toJson());

class GetContractUnitDetailsModel {
  GetContractUnitDetailsModel({
    this.status,
    this.statusCode,
    this.contractUnit,
    this.message,
  });

  String? status;
  String? statusCode;
  ContractUnit? contractUnit;
  String? message;

  factory GetContractUnitDetailsModel.fromJson(Map<String?, dynamic> json) =>
      GetContractUnitDetailsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        contractUnit: ContractUnit.fromJson(json["contractUnit"]),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "contractUnit": contractUnit!.toJson(),
        "message": message,
      };
}

class ContractUnit {
  ContractUnit({
    this.measurementType,
    this.areaSizeSqm,
    this.areasize,
    this.unitId,
    this.propertyImageInByte,
    this.propertyImage,
    this.propertyName,
    this.propertyNameAr,
    this.unitName,
    this.unitNo,
    this.unitCategory,
    this.unitCategoryAr,
    this.landlord,
    this.landlordAr,
    this.unitView,
    this.unitType,
    this.unitViewAr,
    this.unitTypeAr,
    this.currentRent,
    this.floorNo,
    this.bedRooms,
    this.balconies,
    this.kitchens,
    this.livingRooms,
    this.washrooms,
    this.maidRooms,
    this.driverRooms,
    this.contractId,
  });

  String? measurementType;
  dynamic areaSizeSqm;
  String? areasize;
  dynamic unitId;
  dynamic propertyImageInByte;
  String? propertyImage;
  String? propertyName;
  String? propertyNameAr;
  String? unitName;
  String? unitNo;
  String? unitCategory;
  String? unitCategoryAr;
  String? landlord;
  String? landlordAr;
  String? unitView;
  String? unitType;
  String? unitViewAr;
  String? unitTypeAr;
  dynamic currentRent;
  dynamic floorNo;
  dynamic bedRooms;
  dynamic balconies;
  dynamic kitchens;
  dynamic livingRooms;
  dynamic washrooms;
  dynamic maidRooms;
  dynamic driverRooms;
  dynamic contractId;

  factory ContractUnit.fromJson(Map<String?, dynamic> json) {
    final paidFormatter = NumberFormat('#,##0.00', 'AR');
    String? rent = paidFormatter.format(json["currentRent"] ?? 0);
    return ContractUnit(
      measurementType: json["measurementType"],
      areaSizeSqm: json["areaSizeSqm"].toDouble(),
      areasize: json["areasize"],
      unitId: json["unitID"],
      propertyImageInByte: json["propertyImageInByte"],
      propertyImage: json["propertyImage"],
      propertyName: json["propertyName"],
      propertyNameAr: json["propertyNameAR"],
      unitName: json["unitName"],
      unitNo: json["unitNo"],
      unitCategory: json["unitCategory"],
      unitCategoryAr: json["unitCategoryAR"],
      landlord: json["landlord"],
      landlordAr: json["landlordAR"],
      unitView: json["unitView"],
      unitType: json["unitType"],
      unitViewAr: json["unitViewAR"],
      unitTypeAr: json["unitTypeAR"],
      currentRent: rent,
      floorNo: json["floorNo"],
      bedRooms: json["bedRooms"],
      balconies: json["balconies"],
      kitchens: json["kitchens"],
      livingRooms: json["livingRooms"],
      washrooms: json["washrooms"],
      maidRooms: json["maidRooms"],
      driverRooms: json["driverRooms"],
      contractId: json["contractID"],
    );
  }

  Map<String?, dynamic> toJson() => {
        "measurementType": measurementType,
        "areaSizeSqm": areaSizeSqm,
        "areasize": areasize,
        "unitID": unitId,
        "propertyImageInByte": propertyImageInByte,
        "propertyImage": propertyImage,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
        "unitName": unitName,
        "unitNo": unitNo,
        "unitCategory": unitCategory,
        "unitCategoryAR": unitCategoryAr,
        "landlord": landlord,
        "landlordAR": landlordAr,
        "unitView": unitView,
        "unitType": unitType,
        "currentRent": currentRent,
        "floorNo": floorNo,
        "bedRooms": bedRooms,
        "balconies": balconies,
        "kitchens": kitchens,
        "livingRooms": livingRooms,
        "washrooms": washrooms,
        "maidRooms": maidRooms,
        "driverRooms": driverRooms,
        "contractID": contractId,
      };
}
