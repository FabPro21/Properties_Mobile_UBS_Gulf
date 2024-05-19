// To parse this JSON data, do
//
//     final caseCategoryModel = caseCategoryModelFromJson(jsonString);

import 'dart:convert';

CaseCategoryModel caseCategoryModelFromJson(String str) =>
    CaseCategoryModel.fromJson(json.decode(str));

String caseCategoryModelToJson(CaseCategoryModel data) =>
    json.encode(data.toJson());

class CaseCategoryModel {
  CaseCategoryModel({
    this.status,
    this.caseCategories,
    this.message,
  });

  String status;
  List<CaseCategory> caseCategories;
  String message;

  factory CaseCategoryModel.fromJson(Map<String, dynamic> json) =>
      CaseCategoryModel(
        status: json["status"],
        caseCategories: List<CaseCategory>.from(
            json["caseCategories"].map((x) => CaseCategory.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "caseCategories":
            List<dynamic>.from(caseCategories.map((x) => x.toJson())),
        "message": message,
      };
}

class CaseCategory {
  CaseCategory({this.id,
   this.name,
   this.nameAR,
   this.type});

  dynamic id;
  String name;
  String nameAR;
  String type;

  factory CaseCategory.fromJson(Map<String, dynamic> json) =>
      CaseCategory(id: json["id"],
       name: json["name"],
       nameAR: json["nameAR"],
       type: json["type"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nameAR": nameAR,
      };
}
