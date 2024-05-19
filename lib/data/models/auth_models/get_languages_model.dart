// To parse this JSON data, do
//
//     final getLanguagesModel = getLanguagesModelFromJson(jsonString);

import 'dart:convert';

GetLanguagesModel getLanguagesModelFromJson(String str) =>
    GetLanguagesModel.fromJson(json.decode(str));

String getLanguagesModelToJson(GetLanguagesModel data) =>
    json.encode(data.toJson());

class GetLanguagesModel {
  GetLanguagesModel({
    this.message,
    this.status,
    this.statusCode,
    this.language,
  });

  String message;
  String status;
  String statusCode;
  List<Language> language;

  factory GetLanguagesModel.fromJson(Map<String, dynamic> json) =>
      GetLanguagesModel(
        message: json["message"],
        status: json["status"],
        statusCode: json["statusCode"],
        language: List<Language>.from(
            json["language"].map((x) => Language.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "statusCode": statusCode,
        "language": List<dynamic>.from(language.map((x) => x.toJson())),
      };
}

class Language {
  Language({
    this.langId,
    this.title,
  });

  int langId;
  String title;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        langId: json["langId"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "langId": langId,
        "title": title,
      };
}
