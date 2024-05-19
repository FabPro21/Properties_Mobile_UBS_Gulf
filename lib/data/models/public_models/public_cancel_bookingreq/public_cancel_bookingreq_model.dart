// To parse this JSON data, do
//
//     final publicCancelBookingRequestModel = publicCancelBookingRequestModelFromJson(jsonString);

import 'dart:convert';

PublicCancelBookingRequestModel publicCancelBookingRequestModelFromJson(String str) => PublicCancelBookingRequestModel.fromJson(json.decode(str));

String publicCancelBookingRequestModelToJson(PublicCancelBookingRequestModel data) => json.encode(data.toJson());

class PublicCancelBookingRequestModel {
    PublicCancelBookingRequestModel({
        this.status,
        this.message,
    });

    String status;
    String message;

    factory PublicCancelBookingRequestModel.fromJson(Map<String, dynamic> json) => PublicCancelBookingRequestModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
