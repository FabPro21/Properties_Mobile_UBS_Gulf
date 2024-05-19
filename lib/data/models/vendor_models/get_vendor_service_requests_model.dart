// To parse this JSON data, do
//
//     final getVendorServiceRequestDetailsModel = getVendorServiceRequestDetailsModelFromJson(jsonString);

import 'dart:convert';

GetVendorServiceRequests getVendorServiceRequestDetailsModelFromJson(
        String str) =>
    GetVendorServiceRequests.fromJson(json.decode(str));

String getVendorServiceRequestDetailsModelToJson(
        GetVendorServiceRequests data) =>
    json.encode(data.toJson());

class GetVendorServiceRequests {
  GetVendorServiceRequests({
    this.status,
    this.serviceRequests,
    this.message,
  });

  String status;
  List<ServiceRequest> serviceRequests;
  String message;

  factory GetVendorServiceRequests.fromJson(Map<String, dynamic> json) =>
      GetVendorServiceRequests(
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
  ServiceRequest(
      {this.requestNo,
      this.category,
      this.categoryAR,
      this.detail,
      this.date,
      this.propertyName,
      this.propertyNameAR,
      this.status,
      this.statusAR,
      this.units,
      this.subCategory,
      this.subcategoryAR,
      this.unitRefNo});

  int requestNo;
  String category;
  String categoryAR;
  String detail;
  String date;
  String propertyName;
  String propertyNameAR;
  String status;
  String statusAR;
  int units;
  String subCategory;
  String subcategoryAR;
  String unitRefNo;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
      requestNo: json["requestNo"],
      category: json["category"] ?? '',
      categoryAR: json["categoryAR"] ?? '',
      detail: json["detail"],
      date: json["date"],
      propertyName: json["propertyName"] ?? '',
      propertyNameAR: json["propertyNameAR"] ?? '',
      status: json["status"] ?? '',
      statusAR: json["statusAR"] ?? '',
      units: json["units"],
      subCategory: json["subcategory"] ?? '',
      subcategoryAR: json["subcategoryAR"] ?? '',
      unitRefNo: json["unitRefNo"] ?? '');

  Map<String, dynamic> toJson() => {
        "requestNo": requestNo,
        "category": category,
        "detail": detail,
        "date": date,
        "propertyName": propertyName == null ? null : propertyName,
        "status": status == null ? null : status,
        "units": units,
      };
}
