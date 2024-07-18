import 'dart:convert';

VerifyUserOtpModel verifyUserOtpModelFromJson(String str) =>
    VerifyUserOtpModel.fromJson(json.decode(str));

String verifyUserOtpModelToJson(VerifyUserOtpModel data) =>
    json.encode(data.toJson());

class VerifyUserOtpModel {
  VerifyUserOtpModel({
    this.result,
    this.statusCode,
    this.message,
    this.user,
    this.token,
    this.sessionId,
    this.isNewUser,
  });

  String result;
  String statusCode;
  String message;
  User user;
  String token;
  String sessionId;
  bool isNewUser;

  factory VerifyUserOtpModel.fromJson(Map<String, dynamic> json) =>
      VerifyUserOtpModel(
        result: json["result"],
        statusCode: json["statusCode"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: json["token"],
        sessionId: json["sessionId"],
        isNewUser: json["isNewUser"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
        "message": message,
        "user": user.toJson(),
        "token": token,
        "sessionId": sessionId,
      };
}

User userModelFromJson(String str) =>
    User.fromJson(json.decode(str));

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

  int userId;
  dynamic name = '';
  String fullNameAr = '';
  bool mpinSet;
  dynamic mobile;
  dynamic email;
  String language;
  bool languageSet;
  dynamic roles;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        name: json["name"],
        fullNameAr: json['fullNameAr'] ?? 'اسم عربي',
        mpinSet: json["mpinSet"],
        mobile: json["mobile"],
        email: json["email"],
        language: json["language"],
        languageSet: json["languageSet"],
        roles: json["roles"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "mpinSet": mpinSet,
        "mobile": mobile,
        "email": email,
        "language": language,
        "languageSet": languageSet,
        "roles": roles,
      };
}
