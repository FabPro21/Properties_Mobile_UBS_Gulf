// To parse this JSON data, do
//
//     final publicFaqsQuestionAndDescriptionModel = publicFaqsQuestionAndDescriptionModelFromJson(jsonString);

import 'dart:convert';

PublicFaqsQuestionAndDescriptionModel publicFaqsQuestionAndDescriptionModelFromJson(String str) => PublicFaqsQuestionAndDescriptionModel.fromJson(json.decode(str));

String publicFaqsQuestionAndDescriptionModelToJson(PublicFaqsQuestionAndDescriptionModel data) => json.encode(data.toJson());

class PublicFaqsQuestionAndDescriptionModel {
    PublicFaqsQuestionAndDescriptionModel({
        this.status,
        this.faq,
        this.message,
    });

    String status;
    List<Faq> faq;
    String message;

    factory PublicFaqsQuestionAndDescriptionModel.fromJson(Map<String, dynamic> json) => PublicFaqsQuestionAndDescriptionModel(
        status: json["status"],
        faq: List<Faq>.from(json["faq"].map((x) => Faq.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "faq": List<dynamic>.from(faq.map((x) => x.toJson())),
        "message": message,
    };
}

class Faq {
    Faq({
        this.title,
        this.titleAr,
        this.description,
        this.descriptionAr,
    });

    String title;
    String titleAr;
    String description;
    String descriptionAr;

    factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        title: json["title"],
        titleAr: json["titleAR"],
        description: json["description"],
        descriptionAr: json["descriptionAR"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "titleAR": titleAr,
        "description": description,
        "descriptionAR": descriptionAr,
    };
}
