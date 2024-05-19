// To parse this JSON data, do
//
//     final publicGetPropertyManagementModel = publicGetPropertyManagementModelFromJson(jsonString);

import 'dart:convert';

PublicGetPropertyManagementModel publicGetPropertyManagementModelFromJson(
        String str) =>
    PublicGetPropertyManagementModel.fromJson(json.decode(str));

String publicGetPropertyManagementModelToJson(
        PublicGetPropertyManagementModel data) =>
    json.encode(data.toJson());

class PublicGetPropertyManagementModel {
  PublicGetPropertyManagementModel({
    this.status,
    this.record,
    this.message,
  });

  String status;
  List<Record> record;
  String message;

  factory PublicGetPropertyManagementModel.fromJson(
          Map<String, dynamic> json) =>
      PublicGetPropertyManagementModel(
        status: json["status"],
        record:
            List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "record": List<dynamic>.from(record.map((x) => x.toJson())),
        "message": message,
      };
}

class Record {
  Record(
      {this.propertyManagementId,
      this.title,
      this.description,
      this.titileAr,
      this.descriptionAR});

  int propertyManagementId;
  String title;
  String description;
  String titileAr;
  String descriptionAR;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
      propertyManagementId: json["propertyManagementId"],
      title: json["title"],
      description: json["description"],
      titileAr: json["titileAr"],
      descriptionAR: json["descriptionAR"]);

  Map<String, dynamic> toJson() => {
        "propertyManagementId": propertyManagementId,
        "title": title,
        "description": description,
      };
}
