// To parse this JSON data, do
//
//     final getPreferredLanguagesModel = getPreferredLanguagesModelFromJson(jsonString);

import 'dart:convert';

GetPreferredLanguagesModel getPreferredLanguagesModelFromJson(String? str) =>
    GetPreferredLanguagesModel.fromJson(json.decode(str!));

String? getPreferredLanguagesModelToJson(GetPreferredLanguagesModel data) =>
    json.encode(data.toJson());

class GetPreferredLanguagesModel {
  GetPreferredLanguagesModel({
    this.status,
    this.preferredLanguages,
    this.message,
  });

  String? status;
  List<PreferredLanguage>? preferredLanguages;
  String? message;

  factory GetPreferredLanguagesModel.fromJson(Map<String?, dynamic> json) =>
      GetPreferredLanguagesModel(
        status: json["status"],
        preferredLanguages: List<PreferredLanguage>.from(
            json["preferredLanguages"]
                .map((x) => PreferredLanguage.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "preferredLanguages":
            List<dynamic>.from(preferredLanguages!.map((x) => x.toJson())),
        "message": message,
      };
}

class PreferredLanguage {
  PreferredLanguage({
    this.id,
    this.name,
  });

  dynamic id;
  String? name;

  factory PreferredLanguage.fromJson(Map<String?, dynamic> json) =>
      PreferredLanguage(
        id: json["id"],
        name: json["name"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
