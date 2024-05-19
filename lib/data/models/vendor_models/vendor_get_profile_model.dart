// To parse this JSON data, do
//
//     final vendorGetProfileModel = vendorGetProfileModelFromJson(jsonString);

import 'dart:convert';

VendorGetProfileModel vendorGetProfileModelFromJson(String str) =>
    VendorGetProfileModel.fromJson(json.decode(str));

String vendorGetProfileModelToJson(VendorGetProfileModel data) =>
    json.encode(data.toJson());

class VendorGetProfileModel {
  VendorGetProfileModel({
    this.status,
    this.profile,
    this.message,
  });

  String status;
  Profile profile;
  String message;

  factory VendorGetProfileModel.fromJson(Map<String, dynamic> json) =>
      VendorGetProfileModel(
        status: json["status"],
        profile: Profile.fromJson(json["profile"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "profile": profile.toJson(),
        "message": message,
      };
}

class Profile {
  Profile({
    this.contactPersonId,
    this.name,
    this.position,
    this.tradeLicenseNo,
    this.supplierTrn,
    this.lpoStatusName,
    this.lpoStatusNameAr,
    this.countryName,
    this.mobileNo,
    this.phone,
    this.fax,
    this.email,
    this.remarks,
    this.suspend,
    this.contractorId,
    this.isAuthorizedSignatory,
    this.companyName,
    this.companyNameAR,
    this.address,
    this.addressAR,
    this.photoUrl,
  });

  dynamic contactPersonId;
  String name;
  String position;
  String tradeLicenseNo;
  String supplierTrn;
  String lpoStatusName;
  String lpoStatusNameAr;
  String countryName;
  String mobileNo;
  String phone;
  String fax;
  String email;
  String remarks;
  dynamic suspend;
  dynamic contractorId;
  dynamic isAuthorizedSignatory;
  String companyName;
  String companyNameAR;
  String address;
  String addressAR;
  String photoUrl;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        contactPersonId: json["contactPersonID"],
        name: json["name"],
        position: json["position"],
        tradeLicenseNo: json["tradeLicenseNo"],
        supplierTrn: json["supplierTRN"],
        lpoStatusName: json["lpoStatusName"],
        lpoStatusNameAr: json["lpoStatusNameAR"],
        countryName: json["countryName"],
        mobileNo: json["mobileNo"],
        phone: json["phone"],
        fax: json["fax"],
        email: json["email"],
        remarks: json["remarks"],
        suspend: json["suspend"],
        contractorId: json["contractorID"],
        isAuthorizedSignatory: json["isAuthorizedSignatory"],
        companyName: json["companyName"],
        companyNameAR: json["companyNameAR"],
        address: json["address"],
        addressAR: json["addressAR"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "contactPersonID": contactPersonId,
        "name": name,
        "position": position,
        "tradeLicenseNo": tradeLicenseNo,
        "supplierTRN": supplierTrn,
        "lpoStatusName": lpoStatusName,
        "lpoStatusNameAR": lpoStatusNameAr,
        "countryName": countryName,
        "mobileNo": mobileNo,
        "phone": phone,
        "fax": fax,
        "email": email,
        "remarks": remarks,
        "suspend": suspend,
        "contractorID": contractorId,
        "isAuthorizedSignatory": isAuthorizedSignatory,
        "companyName": companyName,
        "companyNameAR": companyNameAR,
        "address": address,
        "addressAR": addressAR,
        "photoUrl": photoUrl,
      };
}
