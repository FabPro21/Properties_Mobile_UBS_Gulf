// To parse this JSON data, do
//
//     final saveServiceRequestModel = saveServiceRequestModelFromJson(jsonString);

import 'dart:convert';

SaveServiceRequestModel saveServiceRequestModelFromJson(String str) =>
    SaveServiceRequestModel.fromJson(json.decode(str));

String saveServiceRequestModelToJson(SaveServiceRequestModel data) =>
    json.encode(data.toJson());

class SaveServiceRequestModel {
  SaveServiceRequestModel({
    this.status,
    this.addServiceRequest,
    this.message,
  });

  String status;
  AddServiceRequest addServiceRequest;
  String message;

  factory SaveServiceRequestModel.fromJson(Map<String, dynamic> json) =>
      SaveServiceRequestModel(
        status: json["status"],
        addServiceRequest:
            AddServiceRequest.fromJson(json["addServiceRequest"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "addServiceRequest": addServiceRequest.toJson(),
        "message": message,
      };
}

class AddServiceRequest {
  AddServiceRequest({
    this.caseNo,
  });

  int caseNo;

  factory AddServiceRequest.fromJson(Map<String, dynamic> json) =>
      AddServiceRequest(
        caseNo: json["caseNo"],
      );

  Map<String, dynamic> toJson() => {
        "caseNo": caseNo,
      };
}
