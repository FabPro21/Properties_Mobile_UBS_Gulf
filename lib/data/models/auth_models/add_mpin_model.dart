// To parse this JSON data, do
//
//     final addMpinModel = addMpinModelFromJson(jsonString);

import 'dart:convert';

AddMpinModel addMpinModelFromJson(String str) =>
    AddMpinModel.fromJson(json.decode(str));

String addMpinModelToJson(AddMpinModel data) => json.encode(data.toJson());

class AddMpinModel {
  AddMpinModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory AddMpinModel.fromJson(Map<String, dynamic> json) => AddMpinModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
