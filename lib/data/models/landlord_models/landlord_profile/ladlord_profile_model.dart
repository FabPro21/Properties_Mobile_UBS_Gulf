// To parse this JSON data, do
//
//     final tenantProfileModel = tenantProfileModelFromJson(jsonString);

import 'dart:convert';

LandLordProfileModel landlordProfileModelFromJson(String? str) =>
    LandLordProfileModel.fromJson(json.decode(str!));

String? landlordProfileModelToJson(LandLordProfileModel data) =>
    json.encode(data.toJson());

class LandLordProfileModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  LandLordProfileModel({this.statusCode, this.message, this.data});

  LandLordProfileModel.fromJson(Map<String?, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? mobile;
  String? landlordName;
  String? landlordNameAR;
  String? landlordID;
  String? email;
  String? nationality;
  String? fax;
  String? phone;
  String? address;
  String? addressAR;
  String? termsAndConditions;
  String? photoUrl;

  Data(
      {this.mobile,
      this.landlordName,
      this.landlordNameAR,
      this.landlordID,
      this.email,
      this.nationality,
      this.fax,
      this.phone,
      this.address,
      this.addressAR,
      this.termsAndConditions,
      this.photoUrl});

  Data.fromJson(Map<String?, dynamic> json) {
    mobile = json['mobile'];
    landlordName = json['landlordName'];
    landlordNameAR = json['landlordNameAR'];
    landlordID = json['landlordID'];
    email = json['email'];
    nationality = json['nationality'];
    fax = json['fax'];
    phone = json['phone'];
    address = json['address'];
    addressAR = json['addressAR'];
    termsAndConditions = json['termsAndConditions'];
    photoUrl = json['photoUrl'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['mobile'] = mobile;
    data['landlordName'] = landlordName;
    data['landlordNameAR'] = landlordNameAR;
    data['landlordID'] = landlordID;
    data['email'] = email;
    data['nationality'] = nationality;
    data['fax'] = fax;
    data['phone'] = phone;
    data['address'] = address;
    data['addressAR'] = addressAR;
    data['termsAndConditions'] = termsAndConditions;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
