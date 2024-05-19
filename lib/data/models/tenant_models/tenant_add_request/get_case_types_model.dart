// To parse this JSON data, do
//
//     final getCaseTypesModel = getCaseTypesModelFromJson(jsonString);

import 'dart:convert';

GetCaseTypesModel getCaseTypesModelFromJson(String str) =>
    GetCaseTypesModel.fromJson(json.decode(str));

String getCaseTypesModelToJson(GetCaseTypesModel data) =>
    json.encode(data.toJson());

class GetCaseTypesModel {
  GetCaseTypesModel({
    this.status,
    this.serviceRequests,
    this.message,
  });

  String status;
  List<ServiceRequest> serviceRequests;
  String message;

  factory GetCaseTypesModel.fromJson(Map<String, dynamic> json) =>
      GetCaseTypesModel(
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
    this.id,
    this.name,
  });

  dynamic id;
  String name;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
        id: json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name == null ? null : name,
      };
}
