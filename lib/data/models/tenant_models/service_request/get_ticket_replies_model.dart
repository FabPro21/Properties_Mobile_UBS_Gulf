// To parse this JSON data, do
//
//     final getTicketRepliesModel = getTicketRepliesModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/state_manager.dart';

GetTicketRepliesModel getTicketRepliesModelFromJson(String? str) =>
    GetTicketRepliesModel.fromJson(json.decode(str!));

String? getTicketRepliesModelToJson(GetTicketRepliesModel data) =>
    json.encode(data.toJson());

class GetTicketRepliesModel {
  GetTicketRepliesModel({
    this.status,
    this.ticketReply,
    this.message,
  });

  String? status;
  List<TicketReply>? ticketReply;
  String? message;

  factory GetTicketRepliesModel.fromJson(Map<String?, dynamic> json) =>
      GetTicketRepliesModel(
        status: json["status"],
        ticketReply: List<TicketReply>.from(
            json["ticketReply"].map((x) => TicketReply.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "ticketReply": List<dynamic>.from(ticketReply!.map((x) => x.toJson())),
        "message": message,
      };
}

class TicketReply {
  TicketReply(
      {this.ticketReplyId,
      this.reply,
      this.dateTime,
      this.userId,
      this.userId2,
      this.fileName,
      this.path});

  int? ticketReplyId;
  String? reply;
  String? dateTime;
  int? userId;
  int? userId2;
  String? fileName;
  RxBool? downloadingFile = false.obs;
  String? path;

  factory TicketReply.fromJson(Map<String?, dynamic> json) => TicketReply(
      ticketReplyId: json["ticketReplyId"] ?? json['id'],
      reply: json["reply"],
      dateTime: json["dateTime"],
      userId: json["userId"],
      userId2: json["publicUserId"],
      fileName: json["fileName"]);

  Map<String?, dynamic> toJson() => {
        "reply": reply,
        "dateTime": dateTime,
        "userId": userId,
      };
}
