// To parse this JSON data, do
//
//     final publicGetProfileModel = publicGetProfileModelFromJson(jsonString);

import 'dart:convert';

PublicGetProfileModel publicGetProfileModelFromJson(String str) => PublicGetProfileModel.fromJson(json.decode(str));

String publicGetProfileModelToJson(PublicGetProfileModel data) => json.encode(data.toJson());

class PublicGetProfileModel {
    PublicGetProfileModel({
        this.status,
        this.profileDetail,
        this.message,
    });

    String status;
    ProfileDetail profileDetail;
    String message;

    factory PublicGetProfileModel.fromJson(Map<String, dynamic> json) => PublicGetProfileModel(
        status: json["status"],
        profileDetail: ProfileDetail.fromJson(json["profileDetail"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "profileDetail": profileDetail.toJson(),
        "message": message,
    };
}

class ProfileDetail {
    ProfileDetail({
        this.email,
        this.mobile,
        this.fullName,
        this.fullNameAr,
        this.userId,
    });

    String email;
    String mobile;
    String fullName;
    dynamic fullNameAr;
    int userId;

    factory ProfileDetail.fromJson(Map<String, dynamic> json) => ProfileDetail(
        email: json["email"],
        mobile: json["mobile"],
        fullName: json["fullName"],
        fullNameAr: json["fullNameAr"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "mobile": mobile,
        "fullName": fullName,
        "fullNameAr": fullNameAr,
        "userId": userId,
    };
}
