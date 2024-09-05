import 'dart:convert';

class GetLpoDataResponse {
  GetLpoDataResponse({
    this.statusCode,
    this.status,
    this.message,
    this.lpos,
  });

  String? statusCode;
  String? status;
  String? message;
  List<Lpo>? lpos;

  factory GetLpoDataResponse.fromRawJson(String? str) =>
      GetLpoDataResponse.fromJson(json.decode(str!));

  factory GetLpoDataResponse.fromJson(Map<String?, dynamic> json) =>
      GetLpoDataResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        lpos: List<Lpo>.from(json["lpos"].map((x) => Lpo.fromJson(x))),
      );
}

class Lpo {
  Lpo({
    this.lpoId,
    this.propertyName,
    this.unitNo,
    this.lpoName,
    this.lpoReference,
    this.netAmount,
    this.lpoDate,
    this.lpoTypeName,
    this.contractor,
    this.completedDate,
    this.lpoTypeId,
  });

  int? lpoId;
  String? propertyName;
  String? unitNo;
  String? lpoName;
  String? lpoReference;
  dynamic netAmount;
  String? lpoDate;
  dynamic lpoTypeName;
  String? contractor;
  String? completedDate;
  int? lpoTypeId;

  factory Lpo.fromRawJson(String? str) => Lpo.fromJson(json.decode(str!));

  factory Lpo.fromJson(Map<String?, dynamic> json) => Lpo(
        lpoId: json["lpoID"],
        propertyName: json["propertyName"],
        unitNo: json["unitNo"],
        lpoName: json["lpoName"],
        lpoReference: json["lpoReference"],
        netAmount: json["netAmount"],
        lpoDate: json["lpoDate"],
        lpoTypeName: json["lpoTypeName"],
        contractor: json["contractor"],
        completedDate: json["completedDate"],
        lpoTypeId: json["lpoTypeID"],
      );
}
