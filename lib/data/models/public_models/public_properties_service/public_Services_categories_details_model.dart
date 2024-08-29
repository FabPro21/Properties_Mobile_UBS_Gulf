// To parse this JSON data, do
//
//     final publicGetServiceDetailsModel = publicGetServiceDetailsModelFromJson(jsonString);

import 'dart:convert';

PublicGetServiceDetailsModel publicGetServiceDetailsModelFromJson(String? str) => PublicGetServiceDetailsModel.fromJson(json.decode(str!));

String? publicGetServiceDetailsModelToJson(PublicGetServiceDetailsModel data) => json.encode(data.toJson());

class PublicGetServiceDetailsModel {
    PublicGetServiceDetailsModel({
        this.status,
        this.services,
        this.message,
    });

    String? status;
    List<Service>? services;
    String? message;

    factory PublicGetServiceDetailsModel.fromJson(Map<String?, dynamic> json) => PublicGetServiceDetailsModel(
        status: json["status"],
        services: List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
        message: json["message"],
    );

    Map<String?, dynamic> toJson() => {
        "status": status,
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
        "message": message,
    };
}

class Service {
    Service({
        this.title,
        this.titleAr,
        this.description,
        this.descriptionAr,
    });

    String? title;
    String? titleAr;
    String? description;
    String? descriptionAr;

    factory Service.fromJson(Map<String?, dynamic> json) => Service(
        title: json["title"],
        titleAr: json["titleAR"],
        description: json["description"],
        descriptionAr: json["descriptionAR"],
    );

    Map<String?, dynamic> toJson() => {
        "title": title,
        "titleAR": titleAr,
        "description": description,
        "descriptionAR": descriptionAr,
    };
}
