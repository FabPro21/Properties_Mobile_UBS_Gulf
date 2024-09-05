// To parse this JSON data, do
//
//     final publicBookingReqGetFeedbackModel = publicBookingReqGetFeedbackModelFromJson(jsonString);

import 'dart:convert';

PublicBookingReqGetFeedbackModel publicBookingReqGetFeedbackModelFromJson(String? str) => PublicBookingReqGetFeedbackModel.fromJson(json.decode(str!));

String? publicBookingReqGetFeedbackModelToJson(PublicBookingReqGetFeedbackModel data) => json.encode(data.toJson());

class PublicBookingReqGetFeedbackModel {
    PublicBookingReqGetFeedbackModel({
        this.status,
        this.feedback,
        this.message,
    });

    String? status;
    Feedback? feedback;
    String? message;

    factory PublicBookingReqGetFeedbackModel.fromJson(Map<String?, dynamic> json) => PublicBookingReqGetFeedbackModel(
        status: json["status"],
        feedback: Feedback.fromJson(json["feedback"]),
        message: json["message"],
    );

    Map<String?, dynamic> toJson() => {
        "status": status,
        "feedback": feedback!.toJson(),
        "message": message,
    };
}

class Feedback {
    Feedback({
        this.caseNo,
        this.description,
        this.rating,
    });

    int? caseNo;
    String? description;
    dynamic rating;

    factory Feedback.fromJson(Map<String?, dynamic> json) => Feedback(
        caseNo: json["caseNo"],
        description: json["description"],
        rating: json["rating"],
    );

    Map<String?, dynamic> toJson() => {
        "caseNo": caseNo,
        "description": description,
        "rating": rating ?? 0.0,
    };
}
