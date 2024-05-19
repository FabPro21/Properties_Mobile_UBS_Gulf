// To parse this JSON data, do
//
//     final publicServiceMyRequestModel = publicServiceMyRequestModelFromJson(jsonString);

import 'dart:convert';

PublicServiceMyRequestModel publicServiceMyRequestModelFromJson(String str) =>
    PublicServiceMyRequestModel.fromJson(json.decode(str));

String publicServiceMyRequestModelToJson(PublicServiceMyRequestModel data) =>
    json.encode(data.toJson());

class PublicServiceMyRequestModel {
  PublicServiceMyRequestModel({
    this.status,
    this.serviceRequests,
    this.message,
  });

  String status;
  List<ServiceRequest> serviceRequests;
  String message;

  factory PublicServiceMyRequestModel.fromJson(Map<String, dynamic> json) =>
      PublicServiceMyRequestModel(
        status: json["status"],
        serviceRequests: List<ServiceRequest>.from(
            json["serviceRequests"].map((x) => ServiceRequest.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "serviceRequests":
            List<dynamic>.from(serviceRequests.map((x) => x.toJson())),
        "message": message,
      };
}

class ServiceRequest {
  ServiceRequest({
    this.requestNo,
    this.category,
    this.subCategory,
    this.subCategoryAR,
    this.categoryAR,
    this.detail,
    this.date,
    this.propertyName,
    this.unitRefNo,
    this.propertyNameAr,
    this.status,
    this.statusAr,
    this.units,
  });

  int requestNo;
  String category;
  String subCategory;
  dynamic subCategoryAR;
  dynamic categoryAR;
  String detail;
  String date;
  String propertyName;
  dynamic unitRefNo;
  String propertyNameAr;
  String status;
  String statusAr;
  int units;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    String status = json["status"] ?? '';
    status.trim();
    return ServiceRequest(
      requestNo: json["requestNo"],
      category: json["category"],
      subCategory: json["subCategory"],
      subCategoryAR: json["subCategoryAR"],
      categoryAR: json["categoryAR"],
      detail: json["detail"],
      date: json["date"],
      propertyName: json["propertyName"],
      unitRefNo: json["unitRefNo"],
      propertyNameAr: json["propertyNameAR"],
      status: status,
      statusAr: json["statusAR"],
      units: json["units"],
    );
  }

  Map<String, dynamic> toJson() => {
        "requestNo": requestNo,
        "category": category,
        "subCategory": subCategory,
        "subCategoryAR": subCategoryAR,
        "categoryAR": categoryAR,
        "detail": detail,
        "date": date,
        "propertyName": propertyName,
        "unitRefNo": unitRefNo,
        "propertyNameAR": propertyNameAr,
        "status": status,
        "statusAR": statusAr,
        "units": units,
      };
}
