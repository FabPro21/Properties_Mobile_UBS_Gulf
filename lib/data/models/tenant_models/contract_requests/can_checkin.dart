// To parse this JSON data, do
//
//     final canCheckinModel = canCheckinModelFromJson(jsonString);

import 'dart:convert';

CanCheckinModel canCheckinModelFromJson(String str) =>
    CanCheckinModel.fromJson(json.decode(str));

String canCheckinModelToJson(CanCheckinModel data) =>
    json.encode(data.toJson());

class CanCheckinModel {
  CanCheckinModel({
    this.checkIn,
    this.caseNo,
  });

  bool? checkIn;
  int? caseNo;

  factory CanCheckinModel.fromJson(Map<String, dynamic> json) =>
      CanCheckinModel(
        checkIn: json["checkIn"],
        caseNo: json["caseNo"],
      );

  Map<String, dynamic> toJson() => {
        "checkIn": checkIn,
        "caseNo": caseNo,
      };
}
