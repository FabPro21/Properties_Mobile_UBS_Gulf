// To parse this JSON data, do
//
//     final vendorFaqsQuestionAndDescriptionModel = vendorFaqsQuestionAndDescriptionModelFromJson(jsonString);

import 'dart:convert';

VendorFaqsQuestionAndDescriptionModel vendorFaqsQuestionAndDescriptionModelFromJson(String str) => VendorFaqsQuestionAndDescriptionModel.fromJson(json.decode(str));

String vendorFaqsQuestionAndDescriptionModelToJson(VendorFaqsQuestionAndDescriptionModel data) => json.encode(data.toJson());

class VendorFaqsQuestionAndDescriptionModel {
    VendorFaqsQuestionAndDescriptionModel({
        this.status,
        this.faq,
        this.message,
    });

    String status;
    List<Faq> faq;
    String message;

    factory VendorFaqsQuestionAndDescriptionModel.fromJson(Map<String, dynamic> json) => VendorFaqsQuestionAndDescriptionModel(
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
