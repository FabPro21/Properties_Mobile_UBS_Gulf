// To parse this JSON data, do
//
//     final getUnitAditionalDetailsModel = getUnitAditionalDetailsModelFromJson(jsonString);

import 'dart:convert';

GetUnitAditionalDetailsModel getUnitAditionalDetailsModelFromJson(String? str) =>
    GetUnitAditionalDetailsModel.fromJson(json.decode(str!));

String? getUnitAditionalDetailsModelToJson(GetUnitAditionalDetailsModel data) =>
    json.encode(data.toJson());

class GetUnitAditionalDetailsModel {
  GetUnitAditionalDetailsModel({
    this.status,
    this.statusCode,
    this.additionalInfo,
    this.message,
  });

  String? status;
  String? statusCode;
  List<AdditionalInfo>? additionalInfo;
  String? message;

  factory GetUnitAditionalDetailsModel.fromJson(Map<String?, dynamic> json) =>
      GetUnitAditionalDetailsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        additionalInfo: List<AdditionalInfo>.from(
            json["additionalInfo"].map((x) => AdditionalInfo.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "additionalInfo":
            List<dynamic>.from(additionalInfo!.map((x) => x.toJson())),
        "message": message,
      };
}

class AdditionalInfo {
  AdditionalInfo({
    this.facilityDescription,
    this.facilityDescriptionAr,
  });

  String? facilityDescription;
  String? facilityDescriptionAr;

  factory AdditionalInfo.fromJson(Map<String?, dynamic> json) => AdditionalInfo(
        facilityDescription: json["facilityDescription"],
        facilityDescriptionAr: json["facilityDescriptionAR"],
      );

  Map<String?, dynamic> toJson() => {
        "facilityDescription": facilityDescription,
        "facilityDescriptionAR": facilityDescriptionAr,
      };
}
