// To parse this JSON data, do
//
//     final tenantUpdateProfileModel = tenantUpdateProfileModelFromJson(jsonString);

import 'dart:convert';

TenantUpdateProfileModel tenantUpdateProfileModelFromJson(String? str) =>
    TenantUpdateProfileModel.fromJson(json.decode(str!));

String? tenantUpdateProfileModelToJson(TenantUpdateProfileModel data) =>
    json.encode(data.toJson());

class TenantUpdateProfileModel {
  TenantUpdateProfileModel({
    this.status,
    this.addServiceRequest,
    this.message,
  });

  String? status;
  AddServiceRequest? addServiceRequest;
  String? message;

  factory TenantUpdateProfileModel.fromJson(Map<String?, dynamic> json) =>
      TenantUpdateProfileModel(
        status: json["status"],
        addServiceRequest:
            AddServiceRequest.fromJson(json["addServiceRequest"]),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "addServiceRequest": addServiceRequest!.toJson(),
        "message": message,
      };
}

class AddServiceRequest {
  AddServiceRequest({
    this.caseNo,
  });

  int? caseNo;

  factory AddServiceRequest.fromJson(Map<String?, dynamic> json) =>
      AddServiceRequest(
        caseNo: json["caseNo"],
      );

  Map<String?, dynamic> toJson() => {
        "caseNo": caseNo,
      };
}
