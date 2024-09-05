// To parse this JSON data, do
//
//     final getAllLpoModel = getAllLpoModelFromJson(jsonString);

import 'dart:convert';

GetAllLpoModel getAllLpoModelFromJson(String? str) =>
    GetAllLpoModel.fromJson(json.decode(str!));

String? getAllLpoModelToJson(GetAllLpoModel data) => json.encode(data.toJson());

class GetAllLpoModel {
  GetAllLpoModel({
    this.statusCode,
    this.status,
    this.message,
    this.lpos,
  });

  String? statusCode;
  String? status;
  String? message;
  List<Lpo>? lpos;

  factory GetAllLpoModel.fromJson(Map<String?, dynamic> json) => GetAllLpoModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        lpos: List<Lpo>.from(json["lpos"].map((x) => Lpo.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "lpos": List<dynamic>.from(lpos!.map((x) => x.toJson())),
      };
}

class Lpo {
  Lpo(
      {this.lpoId,
      this.status,
      this.lpoReference,
      this.docReference,
      this.lpoDate,
      this.grossAmount,
      this.lpoName,
      this.lpoStatus,
      this.lpoStatusAr,
      this.discountAmount,
      this.discountPercentage,
      this.netAmount,
      this.workStatus,
      this.lpoType,
      this.lpoTypeAr,
      this.caseNo});

  dynamic lpoId;
  String? status;
  String? lpoReference;
  String? docReference;
  String? lpoDate;
  dynamic grossAmount;
  String? lpoName;
  String? lpoStatus;
  String? lpoStatusAr;
  dynamic discountAmount;
  dynamic netAmount;
  String? workStatus;
  String? lpoType;
  String? lpoTypeAr;
  double? discountPercentage;
  dynamic caseNo;

  factory Lpo.fromJson(Map<String?, dynamic> json) => Lpo(
      lpoId: json["lpoID"],
      status: json["status"],
      lpoReference: json["lpoReference"],
      docReference: json["docReference"],
      lpoDate: json["lpoDate"],
      grossAmount: json["grossAmount"],
      lpoName: json["lpoName"],
      lpoStatus: json["lpoStatus"] ?? '',
      lpoStatusAr: json["lpoStatusAR"] ?? '',
      discountAmount: json["discountAmount"],
      netAmount: json["netAmount"],
      workStatus: json["workStatus"],
      lpoType: json["lpoType"],
      lpoTypeAr: json["lpoTypeAr"],
      discountPercentage: json["discountPercentage"].toDouble() ?? 0,
      caseNo: json["caseNo"]);

  Map<String?, dynamic> toJson() => {
        "lpoID": lpoId,
        "status": status,
        "lpoReference": lpoReference,
        "docReference": docReference,
        "lpoDate": lpoDate,
        "grossAmount": grossAmount,
        "lpoName": lpoName,
        "lpoStatus": lpoStatus,
        "lpoStatusAR": lpoStatusAr,
        "discountAmount": discountAmount,
        "netAmount": netAmount,
        "workStatus": workStatus,
        "lpoType": lpoType,
        "lpoTypeAr": lpoTypeAr,
      };
}

class LpoFilterData {
  String? dateFrom;
  String? dateTo;
  dynamic statusId;
  String? propName;

  LpoFilterData({this.statusId, this.dateFrom, this.dateTo, this.propName});
}
