// To parse this JSON data, do
//
//     final publicUpdateProfileModel = publicUpdateProfileModelFromJson(jsonString);

import 'dart:convert';

PublicUpdateProfileModel publicUpdateProfileModelFromJson(String? str) =>
    PublicUpdateProfileModel.fromJson(json.decode(str!));

String? publicUpdateProfileModelToJson(PublicUpdateProfileModel data) =>
    json.encode(data.toJson());

class PublicUpdateProfileModel {
  PublicUpdateProfileModel({
    this.status,
    this.addServiceRequest,
    this.message,
  });

  String? status;
  AddServiceRequest? addServiceRequest;
  String? message;

  factory PublicUpdateProfileModel.fromJson(Map<String?, dynamic> json) =>
      PublicUpdateProfileModel(
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
