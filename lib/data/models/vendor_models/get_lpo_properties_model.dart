// To parse this JSON data, do
//
//     final getLpoPropertiesModel = getLpoPropertiesModelFromJson(jsonString);

import 'dart:convert';

GetLpoPropertiesModel getLpoPropertiesModelFromJson(String str) =>
    GetLpoPropertiesModel.fromJson(json.decode(str));

class GetLpoPropertiesModel {
  GetLpoPropertiesModel({
    this.statusCode,
    this.status,
    this.message,
    this.lpoProperties,
  });

  String statusCode;
  String status;
  String message;
  List<LpoProperty> lpoProperties;

  factory GetLpoPropertiesModel.fromJson(Map<String, dynamic> json) =>
      GetLpoPropertiesModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        lpoProperties: List<LpoProperty>.from(
            json["lpoProperties"].map((x) => LpoProperty.fromJson(x))),
      );
}

class LpoProperty {
  LpoProperty(
      {this.lpoPropertyId,
      this.lpoId,
      this.amount,
      this.unitRefNo,
      this.propertyName,
      this.propertyNameAr,
      this.propertyAddress,
      this.propertyAddressAr,
      this.propertyImage,
      this.propertyID});

  dynamic lpoPropertyId;
  dynamic lpoId;
  dynamic amount;
  String unitRefNo;
  String propertyName;
  String propertyNameAr;
  String propertyAddress;
  String propertyAddressAr;
  String propertyImage;
  int propertyID;

  factory LpoProperty.fromJson(Map<String, dynamic> json) => LpoProperty(
      lpoPropertyId: json["lpoPropertyID"],
      lpoId: json["lpoID"],
      amount: json["amount"],
      unitRefNo: json["unitRefNo"],
      propertyName: json["propertyName"],
      propertyNameAr: json["propertyNameAR"],
      propertyAddress: json["propertyAddress"],
      propertyAddressAr: json["propertyAddressAR"],
      propertyImage: json["propertyImage"],
      propertyID: json["propertyID"]);
}
