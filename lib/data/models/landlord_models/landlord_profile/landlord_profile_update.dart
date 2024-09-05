// To parse this JSON data, do
//
//     final LandlordUpdateProfileModel = LandlordUpdateProfileModelFromJson(jsonString);

import 'dart:convert';

LandlordUpdateProfileModel landlordUpdateProfileModelFromJson(String? str) =>
    LandlordUpdateProfileModel.fromJson(json.decode(str!));

String? landlordUpdateProfileModelToJson(LandlordUpdateProfileModel data) =>
    json.encode(data.toJson());

class LandlordUpdateProfileModel {
  LandlordUpdateProfileModel({
    this.status,
    this.addServiceRequest,
    this.message,
  });

  String? status;
  AddServiceRequest? addServiceRequest;
  String? message;

  factory LandlordUpdateProfileModel.fromJson(Map<String?, dynamic> json) =>
      LandlordUpdateProfileModel(
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
