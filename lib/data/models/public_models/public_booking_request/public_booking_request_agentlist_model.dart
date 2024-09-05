// To parse this JSON data, do
//
//     final publicBookingRequestAgentModel = publicBookingRequestAgentModelFromJson(jsonString);

import 'dart:convert';

PublicBookingRequestAgentModel publicBookingRequestAgentModelFromJson(String? str) => PublicBookingRequestAgentModel.fromJson(json.decode(str!));

String? publicBookingRequestAgentModelToJson(PublicBookingRequestAgentModel data) => json.encode(data.toJson());

class PublicBookingRequestAgentModel {
    PublicBookingRequestAgentModel({
        this.status,
        this.agentList,
        this.message,
    });

    String? status;
    List<AgentList>? agentList;
    String? message;

    factory PublicBookingRequestAgentModel.fromJson(Map<String?, dynamic> json) => PublicBookingRequestAgentModel(
        status: json["status"],
        agentList: List<AgentList>.from(json["agentList"].map((x) => AgentList.fromJson(x))),
        message: json["message"],
    );

    Map<String?, dynamic> toJson() => {
        "status": status,
        "agentList": List<dynamic>.from(agentList!.map((x) => x.toJson())),
        "message": message,
    };
}

class AgentList {
    AgentList({
        this.agentId,
        this.agentName,
        this.phone,
        this.email,
        this.nameAr,
    });

    int? agentId;
    String? agentName;
    String? phone;
    String? email;
    String? nameAr;

    factory AgentList.fromJson(Map<String?, dynamic> json) => AgentList(
        agentId: json["agentId"],
        agentName: json["agentName"],
        phone: json["phone"],
        email: json["email"],
        nameAr: json["nameAR"],
    );

    Map<String?, dynamic> toJson() => {
        "agentId": agentId,
        "agentName": agentName,
        "phone": phone,
        "email": email,
        "nameAR": nameAr,
    };
}
