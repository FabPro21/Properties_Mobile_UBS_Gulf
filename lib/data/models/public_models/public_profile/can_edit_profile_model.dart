// To parse this JSON data, do
//
//     final publicCanEditProfileModel = publicCanEditProfileModelFromJson(jsonString);

import 'dart:convert';

PublicCanEditProfileModel publicCanEditProfileModelFromJson(String str) => PublicCanEditProfileModel.fromJson(json.decode(str));

String publicCanEditProfileModelToJson(PublicCanEditProfileModel data) => json.encode(data.toJson());

class PublicCanEditProfileModel {
    PublicCanEditProfileModel({
        this.status,
        this.caseNo,
        this.message,
    });

    String status;
    int caseNo;
    String message;

    factory PublicCanEditProfileModel.fromJson(Map<String, dynamic> json) => PublicCanEditProfileModel(
        status: json["status"],
        caseNo: json["caseNo"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "caseNo": caseNo,
        "message": message,
    };
}
