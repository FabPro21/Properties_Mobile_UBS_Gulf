// To parse this JSON data, do
//
//     final getTenantPropertiesModel = getTenantPropertiesModelFromJson(jsonString);

import 'dart:convert';

GetTenantPropertiesModel getTenantPropertiesModelFromJson(String str) =>
    GetTenantPropertiesModel.fromJson(json.decode(str));

class GetTenantPropertiesModel {
  GetTenantPropertiesModel({
    this.status,
    this.properties,
    this.message,
  });

  String status;
  List<Property> properties;
  String message;

  factory GetTenantPropertiesModel.fromJson(Map<String, dynamic> json) =>
      GetTenantPropertiesModel(
        status: json["status"],
        properties: List<Property>.from(
            json["properties"].map((x) => Property.fromJson(x))),
        message: json["message"],
      );
}

class Property {
  Property(
      {this.contractUnitID, this.unitName, this.unitNameAr, this.propertyName,this.propertyNameAR});

  dynamic contractUnitID;
  String unitName;
  String unitNameAr;
  String propertyName;
  String propertyNameAR;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
      contractUnitID: json["contractUnitID"],
      unitName: json["unitName"],
      unitNameAr: json["unitNameAR"],
      propertyName: json["propertyName"],
      propertyNameAR: json["propertyNameAR"],
      );
}
