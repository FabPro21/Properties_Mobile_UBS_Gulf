// To parse this JSON data, do
//
//     final getPropertyDetailModel = getPropertyDetailModelFromJson(jsonString);

import 'dart:convert';

GetPropertyDetailModel getPropertyDetailModelFromJson(String? str) =>
    GetPropertyDetailModel.fromJson(json.decode(str!));

String? getPropertyDetailModelToJson(GetPropertyDetailModel data) =>
    json.encode(data.toJson());

class GetPropertyDetailModel {
  GetPropertyDetailModel({
    this.statusCode,
    this.status,
    this.message,
    this.property,
  });

  String? statusCode;
  String? status;
  String? message;
  Property? property;

  factory GetPropertyDetailModel.fromJson(Map<String?, dynamic> json) =>
      GetPropertyDetailModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        property: Property.fromJson(json["property"]),
      );

  Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "property": property!.toJson(),
      };
}

class Property {
  Property(
      {this.propertyImage,
      this.unitView,
      this.unitViewAR,
      this.longitude,
      this.latitude,
      this.propertyName,
      this.propertyNameAr,
      this.address,
      this.addressAr,
      this.bedRooms,
      this.noofWashrooms,
      this.areaSize,
      this.landlordName,
      this.unitType,
      this.unitTypeAR,
      this.unitCategoryName,
      this.unitCategoryNameAr,
      this.noofKitchens,
      this.maidRooms,
      this.noofLivingRooms,
      this.noofBalconies,
      this.amount,
      this.unitID,
      this.unitRefNo,
      this.propertyID});

  String? propertyImage;
  String? unitView;
  String? unitViewAR;
  String? longitude;
  String? latitude;
  String? propertyName;
  String? propertyNameAr;
  String? address;
  String? addressAr;
  dynamic bedRooms;
  dynamic noofWashrooms;
  String? areaSize;
  String? landlordName;
  String? unitType;
  String? unitTypeAR;
  String? unitCategoryName;
  String? unitCategoryNameAr;
  dynamic noofKitchens;
  dynamic maidRooms;
  dynamic noofLivingRooms;
  dynamic noofBalconies;
  dynamic amount;
  int? unitID;
  String? unitRefNo;
  int? propertyID;

  factory Property.fromJson(Map<String?, dynamic> json) => Property(
      propertyImage: json["propertyImage"],
      unitView: json["unitView"],
      unitViewAR: json["unitViewAR"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      propertyName: json["propertyName"],
      propertyNameAr: json["propertyNameAR"],
      address: json["address"],
      addressAr: json["addressAR"],
      bedRooms: json["bedRooms"],
      noofWashrooms: json["noofWashrooms"],
      areaSize: json["areaSize"],
      landlordName: json["landlordName"],
      unitType: json["unitType"],
      unitTypeAR: json["unitTypeAR"],
      unitCategoryName: json["unitCategoryName"],
      unitCategoryNameAr: json["unitCategoryNameAR"],
      noofKitchens: json["noofKitchens"],
      maidRooms: json["maidRooms"],
      noofLivingRooms: json["noofLivingRooms"],
      noofBalconies: json["noofBalconies"],
      amount: json["amount"],
      unitID: json["unitID"],
      unitRefNo: json["unitRefNo"],
      propertyID: json["propertyID"]);

  Map<String?, dynamic> toJson() => {
        "propertyImage": propertyImage,
        "unitView": unitView,
        "unitViewAR": unitViewAR,
        "longitude": longitude,
        "latitude": latitude,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
        "address": address,
        "addressAR": addressAr,
        "bedRooms": bedRooms,
        "noofWashrooms": noofWashrooms,
        "areaSize": areaSize,
        "landlordName": landlordName,
        "unitType": unitType,
        "unitTypeAR": unitTypeAR,
        "unitCategoryName": unitCategoryName,
        "unitCategoryNameAR": unitCategoryNameAr,
        "noofKitchens": noofKitchens,
        "maidRooms": maidRooms,
        "noofLivingRooms": noofLivingRooms,
        "noofBalconies": noofBalconies,
        "amount": amount,
      };
}
