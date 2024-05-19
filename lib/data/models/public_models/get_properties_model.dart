// To parse this JSON data, do
//
//     final getPropertiesModel = getPropertiesModelFromJson(jsonString);

import 'dart:convert';

GetPropertiesModel getPropertiesModelFromJson(String str) =>
    GetPropertiesModel.fromJson(json.decode(str));

String getPropertiesModelToJson(GetPropertiesModel data) =>
    json.encode(data.toJson());

class GetPropertiesModel {
  GetPropertiesModel({
    this.statusCode,
    this.status,
    this.message,
    this.property,
  });

  String statusCode;
  String status;
  String message;
  List<Property> property;

  factory GetPropertiesModel.fromJson(Map<String, dynamic> json) =>
      GetPropertiesModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        property: List<Property>.from(
            json["property"].map((x) => Property.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "property": List<dynamic>.from(property.map((x) => x.toJson())),
      };
}

class Property {
  Property(
      {this.propertyId,
      this.propertyImage,
      this.propertyName,
      this.propertyNameAr,
      this.address,
      this.addressAr,
      this.bedRooms,
      this.bath,
      this.areaSize,
      this.premiumAmount,
      this.unitID,
      this.unitRefNo,
      this.rentPerAnnumMin,
      this.unitCategory,
      this.uom
      });

  dynamic propertyId;
  dynamic propertyImage;
  dynamic propertyName;
  dynamic propertyNameAr;
  dynamic address;
  dynamic addressAr;
  dynamic bedRooms;
  dynamic bath;
  dynamic areaSize;
  dynamic premiumAmount;
  int unitID;
  String unitRefNo;
  double rentPerAnnumMin;
  String unitCategory;
  String uom;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
      propertyId: json["propertyID"],
      propertyImage: json["propertyImage"],
      propertyName: json["propertyName"],
      propertyNameAr: json["propertyNameAR"],
      address: json["address"],
      addressAr: json["addressAR"],
      bedRooms: json["bedRooms"],
      bath: json["bath"],
      areaSize: json["areaSize"],
      premiumAmount: json["premiumAmount"],
      unitID: json["unitID"],
      unitRefNo: json["unitRefNo"],
      rentPerAnnumMin: json["rentPerAnnumMin"],
      unitCategory: json["unitCategoryName"],
      uom: json["uom"],
      );

  Map<String, dynamic> toJson() => {
        "propertyID": propertyId,
        "propertyImage": propertyImage,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
        "address": address,
        "addressAR": addressAr,
        "bedRooms": bedRooms,
        "bath": bath,
        "areaSize": areaSize,
        "premiumAmount": premiumAmount,
      };
}
