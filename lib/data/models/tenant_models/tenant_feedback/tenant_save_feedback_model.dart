// To parse this JSON data, do
//
//     final tenantSaveFeedbackModel = tenantSaveFeedbackModelFromJson(jsonString);

import 'dart:convert';

TenantSaveFeedbackModel tenantSaveFeedbackModelFromJson(String? str) => TenantSaveFeedbackModel.fromJson(json.decode(str!));

String? tenantSaveFeedbackModelToJson(TenantSaveFeedbackModel data) => json.encode(data.toJson());

class TenantSaveFeedbackModel {
    TenantSaveFeedbackModel({
        this.status,
        this.message,
    });

    String? status;
    String? message;

    factory TenantSaveFeedbackModel.fromJson(Map<String?, dynamic> json) => TenantSaveFeedbackModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String?, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
