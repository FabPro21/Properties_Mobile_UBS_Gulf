// To parse this JSON data, do
//
//     final publicBookingReqSaveFeedbackModel = publicBookingReqSaveFeedbackModelFromJson(jsonString);

import 'dart:convert';

PublicBookingReqSaveFeedbackModel publicBookingReqSaveFeedbackModelFromJson(String? str) => PublicBookingReqSaveFeedbackModel.fromJson(json.decode(str!));

String? publicBookingReqSaveFeedbackModelToJson(PublicBookingReqSaveFeedbackModel data) => json.encode(data.toJson());

class PublicBookingReqSaveFeedbackModel {
    PublicBookingReqSaveFeedbackModel({
        this.status,
        this.message,
    });

    String? status;
    String? message;

    factory PublicBookingReqSaveFeedbackModel.fromJson(Map<String?, dynamic> json) => PublicBookingReqSaveFeedbackModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String?, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
