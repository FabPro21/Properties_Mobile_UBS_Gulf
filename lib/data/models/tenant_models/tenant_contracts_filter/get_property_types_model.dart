// To parse this JSON data, do
//
//     final getPropertyTypesModel = getPropertyTypesModelFromJson(jsonString);

import 'dart:convert';

GetPropertyTypesModel getPropertyTypesModelFromJson(String str) =>
    GetPropertyTypesModel.fromJson(json.decode(str));

String getPropertyTypesModelToJson(GetPropertyTypesModel data) =>
    json.encode(data.toJson());

class GetPropertyTypesModel {
  GetPropertyTypesModel({
    this.status,
    this.statusCode,
    this.propertyTypes,
    this.message,
  });

  String status;
  String statusCode;
  List<PropertyType> propertyTypes;
  String message;

  factory GetPropertyTypesModel.fromJson(Map<String, dynamic> json) =>
      GetPropertyTypesModel(
        status: json["status"],
        statusCode: json["statusCode"],
        propertyTypes: List<PropertyType>.from(
            json["propertyTypes"].map((x) => PropertyType.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "propertyTypes":
            List<dynamic>.from(propertyTypes.map((x) => x.toJson())),
        "message": message,
      };
}

class PropertyType {
  PropertyType({
    this.propertyType,
    this.propertyTypeId,
    this.propertyTypeAr,
  });

  String propertyType;
  int propertyTypeId;
  String propertyTypeAr;

  factory PropertyType.fromJson(Map<String, dynamic> json) => PropertyType(
        propertyType: json["propertyType"],
        propertyTypeId: json["propertyTypeID"],
        propertyTypeAr: json["propertyTypeAR"],
      );

  Map<String, dynamic> toJson() => {
        "propertyType": propertyType,
        "propertyTypeID": propertyTypeId,
        "propertyTypeAR": propertyTypeAr,
      };
}
