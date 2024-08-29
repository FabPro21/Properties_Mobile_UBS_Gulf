// To parse this JSON data, do
//
//     final getLpoStatusModel = getLpoStatusModelFromJson(jsonString);

import 'dart:convert';

GetLpoStatusModel getLpoStatusModelFromJson(String? str) =>
    GetLpoStatusModel.fromJson(json.decode(str!));

String? getLpoStatusModelToJson(GetLpoStatusModel data) =>
    json.encode(data.toJson());

class GetLpoStatusModel {
  GetLpoStatusModel({
    this.status,
    this.statusCode,
    this.lpoStatus,
    this.message,
  });

  String? status;
  String? statusCode;
  List<LpoStatus>? lpoStatus;
  String? message;

  factory GetLpoStatusModel.fromJson(Map<String?, dynamic> json) =>
      GetLpoStatusModel(
        status: json["status"],
        statusCode: json["statusCode"],
        lpoStatus: List<LpoStatus>.from(
            json["lpoStatus"].map((x) => LpoStatus.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "lpoStatus": List<dynamic>.from(lpoStatus!.map((x) => x.toJson())),
        "message": message,
      };
}

class LpoStatus {
  LpoStatus({
    this.lpoStatusId,
    this.lpoStatusName,
    this.lpoStatusNameAr,
  });

  dynamic lpoStatusId;
  String? lpoStatusName;
  String? lpoStatusNameAr;

  factory LpoStatus.fromJson(Map<String?, dynamic> json) => LpoStatus(
        lpoStatusId: json["lpoStatusID"],
        lpoStatusName: json["lpoStatusName"],
        lpoStatusNameAr: json["lpoStatusNameAr"],
      );

  Map<String?, dynamic> toJson() => {
        "lpoStatusID": lpoStatusId,
        "lpoStatusName": lpoStatusName,
        "lpoStatusNameAr": lpoStatusNameAr,
      };
}
