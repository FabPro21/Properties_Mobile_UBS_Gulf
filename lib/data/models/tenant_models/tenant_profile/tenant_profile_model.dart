// To parse this JSON data, do
//
//     final tenantProfileModel = tenantProfileModelFromJson(jsonString);

import 'dart:convert';

TenantProfileModel tenantProfileModelFromJson(String? str) =>
    TenantProfileModel.fromJson(json.decode(str!));

String? tenantProfileModelToJson(TenantProfileModel data) =>
    json.encode(data.toJson());

class TenantProfileModel {
  TenantProfileModel({
    this.status,
    this.statuCode,
    this.profile,
    this.message,
  });

  String? status;
  String? statuCode;
  Profile? profile;
  String? message;

  factory TenantProfileModel.fromJson(Map<String?, dynamic> json) =>
      TenantProfileModel(
        status: json["status"],
        statuCode: json["statuCode"],
        profile: Profile.fromJson(json["profile"]),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statuCode": statuCode,
        "profile": profile!.toJson(),
        "message": message,
      };
}

class Profile {
  Profile({
    this.tenantId,
    this.name,
    this.nameAr,
    this.addressAr,
    this.mobile,
    this.email,
    this.nationality,
    this.phone,
    this.address,
    this.photoUrl,
    this.fax,
    this.termsAndConditions,
  });

  int? tenantId;
  String? name;
  String? nameAr;
  String? addressAr;
  String? mobile;
  String? email;
  String? nationality;
  String? phone;
  String? address;
  String? photoUrl;
  String? fax;
  String? termsAndConditions;

  factory Profile.fromJson(Map<String?, dynamic> json) {
    String? nameAr = json["nameAR"];
    if (nameAr == ' ') nameAr = 'اسم عربي';
    return Profile(
      tenantId: json["tenantId"],
      name: json["name"],
      nameAr: nameAr,
      addressAr: json["addressAR"],
      mobile: json["mobile"] ?? "",
      email: json["email"],
      nationality: json["nationality"],
      phone: json["phone"],
      address: json["address"],
      photoUrl: json["photoUrl"],
      fax: json["fax"],
      termsAndConditions: json["termsAndConditions"],
    );
  }

  Map<String?, dynamic> toJson() => {
        "tenantId": tenantId,
        "name": name,
        "nameAR": nameAr,
        "addressAR": addressAr,
        "mobile": mobile,
        "email": email,
        "nationality": nationality,
        "phone": phone,
        "address": address,
        "photoUrl": photoUrl,
        "fax": fax,
        "termsAndConditions": termsAndConditions,
      };
}
