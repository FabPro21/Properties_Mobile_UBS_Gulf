// To parse this JSON data, do
//
//     final getLpoDetailsResponse = getLpoDetailsResponseFromJson(jsonString);

import 'dart:convert';

class GetLpoDetailsResponse {
    GetLpoDetailsResponse({
        this.statusCode,
        this.status,
        this.message,
        this.lpos,
    });

    String? statusCode;
    String? status;
    String? message;
    Lpos? lpos;

    factory GetLpoDetailsResponse.fromRawJson(String? str) => GetLpoDetailsResponse.fromJson(json.decode(str!));

    String? toRawJson() => json.encode(toJson());

    factory GetLpoDetailsResponse.fromJson(Map<String?, dynamic> json) => GetLpoDetailsResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        lpos: Lpos.fromJson(json["lpos"]),
    );

    Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "lpos": lpos!.toJson(),
    };
}

class Lpos {
    Lpos({
        this.lpoId,
        this.propertyName,
        this.unitNo,
        this.lpoName,
        this.lpoReference,
        this.netAmount,
        this.discountAmount,
        this.discountPercentage,
        this.crossAmount,
        this.lpoDate,
        this.lpoTypeName,
        this.supplier,
        this.supplierReference,
        this.completedDate,
        this.deliveryDate,
        this.lpoTypeId,
        this.details,
    });

    int? lpoId;
    String? propertyName;
    String? unitNo;
    String? lpoName;
    String? lpoReference;
    dynamic netAmount;
    dynamic discountAmount;
    dynamic discountPercentage;
    dynamic crossAmount;
    String? lpoDate;
    dynamic lpoTypeName;
    String? supplier;
    String? supplierReference;
    String? completedDate;
    String? deliveryDate;
    int? lpoTypeId;
    String? details;

    factory Lpos.fromRawJson(String? str) => Lpos.fromJson(json.decode(str!));

    String? toRawJson() => json.encode(toJson());

    factory Lpos.fromJson(Map<String?, dynamic> json) => Lpos(
        lpoId: json["lpoID"],
        propertyName: json["propertyName"],
        unitNo: json["unitNo"],
        lpoName: json["lpoName"],
        lpoReference: json["lpoReference"],
        netAmount: json["netAmount"],
        discountAmount: json["discountAmount"],
        discountPercentage: json["discountPercentage"].toDouble(),
        crossAmount: json["crossAmount"],
        lpoDate: json["lpoDate"],
        lpoTypeName: json["lpoTypeName"],
        supplier: json["supplier"],
        supplierReference: json["supplierReference"],
        completedDate: json["completedDate"],
        deliveryDate: json["deliveryDate"],
        lpoTypeId: json["lpoTypeID"],
        details: json["details"],
    );

    Map<String?, dynamic> toJson() => {
        "lpoID": lpoId,
        "propertyName": propertyName,
        "unitNo": unitNo,
        "lpoName": lpoName,
        "lpoReference": lpoReference,
        "netAmount": netAmount,
        "discountAmount": discountAmount,
        "discountPercentage": discountPercentage,
        "crossAmount": crossAmount,
        "lpoDate": lpoDate,
        "lpoTypeName": lpoTypeName,
        "supplier": supplier,
        "supplierReference": supplierReference,
        "completedDate": completedDate,
        "deliveryDate": deliveryDate,
        "lpoTypeID": lpoTypeId,
        "details": details,
    };
}
