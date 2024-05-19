// To parse this JSON data, do
//
//     final tenantFaqsModel = tenantFaqsModelFromJson(jsonString);

import 'dart:convert';

TenantFaqsModel tenantFaqsModelFromJson(String str) => TenantFaqsModel.fromJson(json.decode(str));

String tenantFaqsModelToJson(TenantFaqsModel data) => json.encode(data.toJson());

class TenantFaqsModel {
    TenantFaqsModel({
        this.status,
        this.faqCategories,
        this.message,
    });

    String status;
    List<FaqCategory> faqCategories;
    String message;

    factory TenantFaqsModel.fromJson(Map<String, dynamic> json) => TenantFaqsModel(
        status: json["status"],
        faqCategories: List<FaqCategory>.from(json["faqCategories"].map((x) => FaqCategory.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "faqCategories": List<dynamic>.from(faqCategories.map((x) => x.toJson())),
        "message": message,
    };
}

class FaqCategory {
    FaqCategory({
        this.categoryId,
        this.title,
        this.titleAr,
    });

    int categoryId;
    String title;
    String titleAr;

    factory FaqCategory.fromJson(Map<String, dynamic> json) => FaqCategory(
        categoryId: json["categoryId"],
        title: json["title"],
        titleAr: json["titleAR"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "title": title,
        "titleAR": titleAr,
    };
}
