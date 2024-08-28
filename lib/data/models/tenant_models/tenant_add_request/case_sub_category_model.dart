// To parse this JSON data, do
//
//     final caseSubCategoryModel = caseSubCategoryModelFromJson(jsonString);

import 'dart:convert';

CaseSubCategoryModel caseSubCategoryModelFromJson(String? str) =>
    CaseSubCategoryModel.fromJson(json.decode(str!));

String? caseSubCategoryModelToJson(CaseSubCategoryModel data) =>
    json.encode(data.toJson());

class CaseSubCategoryModel {
  CaseSubCategoryModel({
    this.status,
    this.caseSubCategories,
    this.message,
  });

  String? status;
  List<CaseSubCategory>? caseSubCategories;
  String? message;

  factory CaseSubCategoryModel.fromJson(Map<String?, dynamic> json) =>
      CaseSubCategoryModel(
        status: json["status"],
        caseSubCategories: List<CaseSubCategory>.from(
            json["caseSubCategories"].map((x) => CaseSubCategory.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "caseSubCategories":
            List<dynamic>.from(caseSubCategories!.map((x) => x.toJson())),
        "message": message,
      };
}

class CaseSubCategory {
  CaseSubCategory({
    this.id,
    this.name,
    this.nameAR,
  });

  dynamic id;
  String? name;
  String? nameAR;

  factory CaseSubCategory.fromJson(Map<String?, dynamic> json) =>
      CaseSubCategory(
        id: json["id"],
        name: json["name"],
        nameAR: json["nameAR"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nameAR": nameAR,
      };
}
