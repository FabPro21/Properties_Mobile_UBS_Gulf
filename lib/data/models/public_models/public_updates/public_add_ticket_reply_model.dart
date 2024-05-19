// To parse this JSON data, do
//
//     final publicAddTicketReplyModel = publicAddTicketReplyModelFromJson(jsonString);

import 'dart:convert';

PublicAddTicketReplyModel publicAddTicketReplyModelFromJson(String str) => PublicAddTicketReplyModel.fromJson(json.decode(str));

String publicAddTicketReplyModelToJson(PublicAddTicketReplyModel data) => json.encode(data.toJson());

class PublicAddTicketReplyModel {
    PublicAddTicketReplyModel({
        this.status,
        this.message,
    });

    String status;
    String message;

    factory PublicAddTicketReplyModel.fromJson(Map<String, dynamic> json) => PublicAddTicketReplyModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
