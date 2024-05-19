// To parse this JSON data, do
//
//     final publicGetServiceCategoriesModel = publicGetServiceCategoriesModelFromJson(jsonString);

import 'dart:convert';

PublicGetServiceCategoriesModel publicGetServiceCategoriesModelFromJson(String str) => PublicGetServiceCategoriesModel.fromJson(json.decode(str));

String publicGetServiceCategoriesModelToJson(PublicGetServiceCategoriesModel data) => json.encode(data.toJson());

class PublicGetServiceCategoriesModel {
    PublicGetServiceCategoriesModel({
        this.status,
        this.serviceCategories,
        this.message,
    });

    String status;
    List<ServiceCategory> serviceCategories;
    String message;

    factory PublicGetServiceCategoriesModel.fromJson(Map<String, dynamic> json) => PublicGetServiceCategoriesModel(
        status: json["status"],
        serviceCategories: List<ServiceCategory>.from(json["serviceCategories"].map((x) => ServiceCategory.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "serviceCategories": List<dynamic>.from(serviceCategories.map((x) => x.toJson())),
        "message": message,
    };
}

class ServiceCategory {
    ServiceCategory({
        this.title,
        this.titleAr,
        this.categoryId,
    });

    String title;
    String titleAr;
    int categoryId;

    factory ServiceCategory.fromJson(Map<String, dynamic> json) => ServiceCategory(
        title: json["title"],
        titleAr: json["titleAR"],
        categoryId: json["categoryId"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "titleAR": titleAr,
        "categoryId": categoryId,
    };
}
