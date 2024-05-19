// To parse this JSON data, do
//
//     final vacatingReasons = vacatingReasonsFromJson(jsonString);

import 'dart:convert';

VacatingReasons vacatingReasonsFromJson(String str) =>
    VacatingReasons.fromJson(json.decode(str));

String vacatingReasonsToJson(VacatingReasons data) =>
    json.encode(data.toJson());

class VacatingReasons {
  VacatingReasons({this.status, this.record, this.message, this.note});

  String status;
  List<Record> record;
  String message;
  String note;

  factory VacatingReasons.fromJson(Map<String, dynamic> json) =>
      VacatingReasons(
          status: json["status"],
          record:
              List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
          message: json["message"],
          note: json["note"]);

  Map<String, dynamic> toJson() => {
        "status": status,
        "record": List<dynamic>.from(record.map((x) => x.toJson())),
        "message": message,
      };
}

class Record {
  Record({
    this.vacatingId,
    this.title,
    this.titleAr,
    this.description,
    this.descriptionAr,
  });

  int vacatingId;
  String title;
  String titleAr;
  String description;
  String descriptionAr;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        vacatingId: json["vacatingId"],
        title: json["title"],
        titleAr: json["titleAr"],
        description: json["description"],
        descriptionAr: json["descriptionAR"],
      );

  Map<String, dynamic> toJson() => {
        "vacatingId": vacatingId,
        "title": title,
        "titleAr": titleAr,
        "description": description,
        "descriptionAR": descriptionAr,
      };
}
