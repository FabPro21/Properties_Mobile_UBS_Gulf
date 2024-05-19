// To parse this JSON data, do
//
//     final publicGetTicketReplyModel = publicGetTicketReplyModelFromJson(jsonString);

import 'dart:convert';

PublicGetTicketReplyModel publicGetTicketReplyModelFromJson(String str) => PublicGetTicketReplyModel.fromJson(json.decode(str));

String publicGetTicketReplyModelToJson(PublicGetTicketReplyModel data) => json.encode(data.toJson());

class PublicGetTicketReplyModel {
    PublicGetTicketReplyModel({
        this.status,
        this.ticketReply,
        this.message,
    });

    String status;
    List<TicketReply> ticketReply;
    String message;

    factory PublicGetTicketReplyModel.fromJson(Map<String, dynamic> json) => PublicGetTicketReplyModel(
        status: json["status"],
        ticketReply: List<TicketReply>.from(json["ticketReply"].map((x) => TicketReply.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "ticketReply": List<dynamic>.from(ticketReply.map((x) => x.toJson())),
        "message": message,
    };
}

class TicketReply {
    TicketReply({
        this.reply,
        this.dateTime,
        this.publicUserId,
        this.userid,
    });

    String reply; 
    String dateTime;
    int publicUserId;
    int userid;

    factory TicketReply.fromJson(Map<String, dynamic> json) => TicketReply(
        reply: json["reply"],
        dateTime: json["dateTime"],
        publicUserId: json["publicUserId"],
        userid: json["userid"],
    );

    Map<String, dynamic> toJson() => {
        "reply": reply,
        "dateTime": dateTime,
        "publicUserId": publicUserId,
        "userid": userid,
    };
}
