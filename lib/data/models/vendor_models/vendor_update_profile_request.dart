// To parse this JSON data, do
//
//     final vendorUpdateProfileRequest = vendorUpdateProfileRequestFromJson(jsonString);

import 'dart:convert';

VendorUpdateProfileRequest vendorUpdateProfileRequestFromJson(String? str) =>
    VendorUpdateProfileRequest.fromJson(json.decode(str!));

String? vendorUpdateProfileRequestToJson(VendorUpdateProfileRequest data) =>
    json.encode(data.toJson());

class VendorUpdateProfileRequest {
  VendorUpdateProfileRequest({
    this.status,
    this.addServiceRequest,
    this.message,
    this.document,
  });

  String? status;
  AddServiceRequest? addServiceRequest;
  String? message;
  List<dynamic>? document;

  factory VendorUpdateProfileRequest.fromJson(Map<String?, dynamic> json) =>
      VendorUpdateProfileRequest(
        status: json["status"],
        addServiceRequest:
            AddServiceRequest.fromJson(json["addServiceRequest"]),
        message: json["message"],
        document: List<dynamic>.from(json["document"].map((x) => x)),
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "addServiceRequest": addServiceRequest!.toJson(),
        "message": message,
        "document": List<dynamic>.from(document!.map((x) => x)),
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
