// To parse this JSON data, do
//
//     final getNewTokenModel = getNewTokenModelFromJson(jsonString);

import 'dart:convert';

GetNewTokenModel getNewTokenModelFromJson(String? str) => GetNewTokenModel.fromJson(json.decode(str!));

String? getNewTokenModelToJson(GetNewTokenModel data) => json.encode(data.toJson());

class GetNewTokenModel {
    GetNewTokenModel({
        this.token,
        this.user,
        this.message,
        this.status,
        this.statusCode,
    });

    String? token;
    User? user;
    String? message;
    String? status;
    String? statusCode;

    factory GetNewTokenModel.fromJson(Map<String?, dynamic> json) => GetNewTokenModel(
        token: json["token"],
        user: User.fromJson(json["user"]),
        message: json["message"],
        status: json["status"],
        statusCode: json["statusCode"],
    );

    Map<String?, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
        "message": message,
        "status": status,
        "statusCode": statusCode,
    };
}

class User {
    User({
        this.userId,
        this.name,
        this.fullNameAr,
        this.mpinSet,
        this.mobile,
        this.email,
        this.language,
        this.languageSet,
        this.roles,
    });

    int? userId;
    String? name;
    dynamic fullNameAr;
    bool? mpinSet;
    String? mobile;
    String? email;
    dynamic language;
    dynamic languageSet;
    dynamic roles;

    factory User.fromJson(Map<String?, dynamic> json) => User(
        userId: json["userId"],
        name: json["name"],
        fullNameAr: json["fullNameAr"],
        mpinSet: json["mpinSet"],
        mobile: json["mobile"],
        email: json["email"],
        language: json["language"],
        languageSet: json["languageSet"],
        roles: json["roles"],
    );

    Map<String?, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "fullNameAr": fullNameAr,
        "mpinSet": mpinSet,
        "mobile": mobile,
        "email": email,
        "language": language,
        "languageSet": languageSet,
        "roles": roles,
    };
}
