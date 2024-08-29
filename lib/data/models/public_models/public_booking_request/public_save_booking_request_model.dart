// To parse this JSON data, do
//
//     final publicSaveBookingRequestModel = publicSaveBookingRequestModelFromJson(jsonString);

import 'dart:convert';

PublicSaveBookingRequestModel publicSaveBookingRequestModelFromJson(String? str) => PublicSaveBookingRequestModel.fromJson(json.decode(str!));

String? publicSaveBookingRequestModelToJson(PublicSaveBookingRequestModel data) => json.encode(data.toJson());

class PublicSaveBookingRequestModel {
    PublicSaveBookingRequestModel({
        this.status,
        this.addServiceRequest,
        this.message,
    });

    String? status;
    AddServiceRequest? addServiceRequest;
    String? message;

    factory PublicSaveBookingRequestModel.fromJson(Map<String?, dynamic> json) => PublicSaveBookingRequestModel(
        status: json["status"],
        addServiceRequest: AddServiceRequest.fromJson(json["addServiceRequest"]),
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

    factory AddServiceRequest.fromJson(Map<String?, dynamic> json) => AddServiceRequest(
        caseNo: json["caseNo"],
    );

    Map<String?, dynamic> toJson() => {
        "caseNo": caseNo,
    };
}
