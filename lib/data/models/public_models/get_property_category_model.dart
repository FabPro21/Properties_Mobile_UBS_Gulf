// To parse this JSON data, do
//
//     final getPropertyCategoryModel = getPropertyCategoryModelFromJson(jsonString);

import 'dart:convert';

GetPropertyCategoryModel getPropertyCategoryModelFromJson(String? str) =>
    GetPropertyCategoryModel.fromJson(json.decode(str!));

String? getPropertyCategoryModelToJson(GetPropertyCategoryModel data) =>
    json.encode(data.toJson());

class GetPropertyCategoryModel {
  GetPropertyCategoryModel({
    this.statusCode,
    this.status,
    this.message,
    this.propertyCategory,
  });

  String? statusCode;
  String? status;
  String? message;
  List<PropertyCategory>? propertyCategory;

  factory GetPropertyCategoryModel.fromJson(Map<String?, dynamic> json) =>
      GetPropertyCategoryModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        propertyCategory: List<PropertyCategory>.from(
            json["propertyCategory"].map((x) => PropertyCategory.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "propertyCategory":
            List<dynamic>.from(propertyCategory!.map((x) => x.toJson())),
      };
}

class PropertyCategory {
  PropertyCategory({
    this.propertyCategoryId,
    this.propertyCategory,
    this.propertyCategoryAr,
  });

  int? propertyCategoryId;
  String? propertyCategory;
  String? propertyCategoryAr;

  factory PropertyCategory.fromJson(Map<String?, dynamic> json) =>
      PropertyCategory(
        propertyCategoryId: json["propertyCategoryID"],
        propertyCategory: json["propertyCategory"],
        propertyCategoryAr: json["propertyCategoryAR"],
      );

  Map<String?, dynamic> toJson() => {
        "propertyCategoryID": propertyCategoryId,
        "propertyCategory": propertyCategory,
        "propertyCategoryAR": propertyCategoryAr,
      };
}
