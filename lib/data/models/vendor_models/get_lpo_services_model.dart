// To parse this JSON data, do
//
//     final getLpoServicesModel = getLpoServicesModelFromJson(jsonString);

import 'dart:convert';

GetLpoServicesModel getLpoServicesModelFromJson(String str) =>
    GetLpoServicesModel.fromJson(json.decode(str));

String getLpoServicesModelToJson(GetLpoServicesModel data) =>
    json.encode(data.toJson());

class GetLpoServicesModel {
  GetLpoServicesModel({
    this.statusCode,
    this.status,
    this.message,
    this.lpoServices,
  });

  String statusCode;
  String status;
  String message;
  List<LpoService> lpoServices;

  factory GetLpoServicesModel.fromJson(Map<String, dynamic> json) =>
      GetLpoServicesModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        lpoServices: List<LpoService>.from(
            json["lpoServices"].map((x) => LpoService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "lpoServices": List<dynamic>.from(lpoServices.map((x) => x.toJson())),
      };
}

class LpoService {
  LpoService({
    this.serviceLpoId,
    this.lpoId,
    this.serviceLpoName,
    this.serviceLpoNameAr,
    this.description,
    this.descriptionAr,
    this.completionDate,
    this.netAmount,
    this.discountAmount,
    this.discountPercentage,
    this.requestAmount,
    this.totalAmount,
  });

  int serviceLpoId;
  int lpoId;
  String serviceLpoName;
  dynamic serviceLpoNameAr;
  String description;
  dynamic descriptionAr;
  String completionDate;
  dynamic netAmount;
  dynamic discountAmount;
  dynamic discountPercentage;
  dynamic requestAmount;
  dynamic totalAmount;

  factory LpoService.fromJson(Map<String, dynamic> json) => LpoService(
        serviceLpoId: json["serviceLpoId"],
        lpoId: json["lpoID"],
        serviceLpoName: json["serviceLpoName"],
        serviceLpoNameAr: json["serviceLpoNameAR"],
        description: json["description"],
        descriptionAr: json["descriptionAR"],
        completionDate: json["completionDate"],
        netAmount: json["netAmount"],
        discountAmount: json["discountAmount"],
        discountPercentage: json["discountPercentage"],
        requestAmount: json["requestAmount"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "serviceLpoId": serviceLpoId,
        "lpoID": lpoId,
        "serviceLpoName": serviceLpoName,
        "serviceLpoNameAR": serviceLpoNameAr,
        "description": description,
        "descriptionAR": descriptionAr,
        "completionDate": completionDate,
        "netAmount": netAmount,
        "discountAmount": discountAmount,
        "discountPercentage": discountPercentage,
        "requestAmount": requestAmount,
        "totalAmount": totalAmount,
      };
}
