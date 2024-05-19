// To parse this JSON data, do
//
//     final vendorGetContactPersonsModel = vendorGetContactPersonsModelFromJson(jsonString);

import 'dart:convert';

VendorGetContactPersonsModel vendorGetContactPersonsModelFromJson(String str) =>
    VendorGetContactPersonsModel.fromJson(json.decode(str));

String vendorGetContactPersonsModelToJson(VendorGetContactPersonsModel data) =>
    json.encode(data.toJson());

class VendorGetContactPersonsModel {
  VendorGetContactPersonsModel({
    this.statusCode,
    this.status,
    this.message,
    this.contactPersons,
  });

  String statusCode;
  String status;
  String message;
  List<ContactPerson> contactPersons;

  factory VendorGetContactPersonsModel.fromJson(Map<String, dynamic> json) =>
      VendorGetContactPersonsModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        contactPersons: List<ContactPerson>.from(
            json["contactPersons"].map((x) => ContactPerson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "contactPersons":
            List<dynamic>.from(contactPersons.map((x) => x.toJson())),
      };
}

class ContactPerson {
  ContactPerson({
    this.vendorId,
    this.name,
    this.nameAr,
    this.position,
    this.positionAR,
    this.mobile,
    this.phone,
    this.email,
    this.faxNumber,
    this.isAuthorizedSignatory,
    this.isAuthorizedSignatoryAR,
  });

  dynamic vendorId;
  String name;
  String nameAr;
  String position;
  String positionAR;
  String mobile;
  dynamic phone;
  String email;
  dynamic faxNumber;
  String isAuthorizedSignatory;
  String isAuthorizedSignatoryAR;

  factory ContactPerson.fromJson(Map<String, dynamic> json) => ContactPerson(
        vendorId: json["vendorId"],
        name: json["name"],
        nameAr: json["nameAR"],
        position: json["position"],
        positionAR: json["positionAR"],
        mobile: json["mobile"],
        phone: json["phone"],
        email: json["email"],
        faxNumber: json["faxNumber"],
        isAuthorizedSignatory: json["isAuthorizedSignatory"],
        isAuthorizedSignatoryAR: json["isAuthorizedSignatoryAR"],
      );

  Map<String, dynamic> toJson() => {
        "vendorId": vendorId,
        "name": name,
        "nameAR": nameAr,
        "position": position,
        "positionAR": positionAR,
        "mobile": mobile,
        "phone": phone,
        "email": email,
        "faxNumber": faxNumber,
        "isAuthorizedSignatory": isAuthorizedSignatory,
        "isAuthorizedSignatoryAR": isAuthorizedSignatoryAR,
      };
}
