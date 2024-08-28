// To parse this JSON data, do
//
//     final tenantGetSrFeedback = tenantGetSrFeedbackFromJson(jsonString);

import 'dart:convert';

TenantGetSrFeedback tenantGetSrFeedbackFromJson(String? str) =>
    TenantGetSrFeedback.fromJson(json.decode(str!));

String? tenantGetSrFeedbackToJson(TenantGetSrFeedback data) =>
    json.encode(data.toJson());

class TenantGetSrFeedback {
  TenantGetSrFeedback({
    this.status,
    this.feedback,
    this.message,
  });

  String? status;
  Feedback? feedback;
  String? message;

  factory TenantGetSrFeedback.fromJson(Map<String?, dynamic> json) =>
      TenantGetSrFeedback(
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
  double? rating;

  factory Feedback.fromJson(Map<String?, dynamic> json) => Feedback(
        caseNo: json["caseNo"] ?? 0,
        description: json["description"] ?? '',
        rating: json["rating"] ?? 0.0,
      );

  Map<String?, dynamic> toJson() => {
        "caseNo": caseNo,
        "description": description,
        "rating": rating,
      };
}
