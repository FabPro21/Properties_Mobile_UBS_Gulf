// To parse this JSON data, do
//
//     final getContactTimingModel = getContactTimingModelFromJson(jsonString);

import 'dart:convert';

GetContactTimingModel getContactTimingModelFromJson(String? str) =>
    GetContactTimingModel.fromJson(json.decode(str!));

String? getContactTimingModelToJson(GetContactTimingModel data) =>
    json.encode(data.toJson());

class GetContactTimingModel {
  GetContactTimingModel({
    this.status,
    this.contactTiming,
    this.message,
  });

  String? status;
  List<ContactTiming>? contactTiming;
  String? message;

  factory GetContactTimingModel.fromJson(Map<String?, dynamic> json) =>
      GetContactTimingModel(
        status: json["status"],
        contactTiming: List<ContactTiming>.from(
            json["contactTiming"].map((x) => ContactTiming.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "contactTiming":
            List<dynamic>.from(contactTiming!.map((x) => x.toJson())),
        "message": message,
      };
}

class ContactTiming {
  ContactTiming({
    this.id,
    this.name,
  });

  dynamic id;
  String? name;

  factory ContactTiming.fromJson(Map<String?, dynamic> json) => ContactTiming(
        id: json["id"],
        name: json["name"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
