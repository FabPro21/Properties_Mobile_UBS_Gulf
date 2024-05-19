// To parse this JSON data, do
//
//     final refreshTokenModel = refreshTokenModelFromJson(jsonString);

import 'dart:convert';

RefreshTokenModel refreshTokenModelFromJson(String str) => RefreshTokenModel.fromJson(json.decode(str));

String refreshTokenModelToJson(RefreshTokenModel data) => json.encode(data.toJson());

class RefreshTokenModel {
    RefreshTokenModel({
        this.statustCode,
        this.status,
        this.userId,
        this.userRole,
        this.token,
        this.message,
    });

    String statustCode;
    String status;
    int userId;
    String userRole;
    String token;
    String message;

    factory RefreshTokenModel.fromJson(Map<String, dynamic> json) => RefreshTokenModel(
        statustCode: json["statustCode"],
        status: json["status"],
        userId: json["userId"],
        userRole: json["userRole"],
        token: json["token"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "statustCode": statustCode,
        "status": status,
        "userId": userId,
        "userRole": userRole,
        "token": token,
        "message": message,
    };
}
