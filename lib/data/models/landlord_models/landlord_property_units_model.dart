// To parse this JSON data, do
//
//     final landlordPropertyUnitsModel = landlordPropertyUnitsModelFromJson(jsonString);

import 'dart:convert';

LandlordPropertyUnitsModel landlordPropertyUnitsModelFromJson(String str) =>
    LandlordPropertyUnitsModel.fromJson(json.decode(str));

String landlordPropertyUnitsModelToJson(LandlordPropertyUnitsModel data) =>
    json.encode(data.toJson());

class LandlordPropertyUnitsModel {
  String status;
  List<Cities> cities;
  String message;

  LandlordPropertyUnitsModel({this.status, this.cities, this.message});

  LandlordPropertyUnitsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities.add(new Cities.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Cities {
  dynamic measurementType;
  dynamic areaSizeSqm;
  String areasize;
  dynamic unitID;
  dynamic propertyImageInByte;
  String propertyImage;
  String propertyName;
  String propertyNameAR;
  String unitName;
  dynamic unitTypeAR;
  dynamic unitViewAR;
  String unitRefNo;
  String unitNo;
  String unitCategory;
  String unitCategoryAR;
  String landlord;
  String landlordAR;
  String unitView;
  String unitType;
  dynamic currentRent;
  dynamic floorNo;
  dynamic bedRooms;
  dynamic balconies;
  dynamic kitchens;
  dynamic livingRooms;
  dynamic washrooms;
  dynamic maidRooms;
  dynamic driverRooms;
  dynamic contractID;

  Cities(
      {this.measurementType,
      this.areaSizeSqm,
      this.areasize,
      this.unitID,
      this.propertyImageInByte,
      this.propertyImage,
      this.propertyName,
      this.propertyNameAR,
      this.unitName,
      this.unitTypeAR,
      this.unitViewAR,
      this.unitRefNo,
      this.unitNo,
      this.unitCategory,
      this.unitCategoryAR,
      this.landlord,
      this.landlordAR,
      this.unitView,
      this.unitType,
      this.currentRent,
      this.floorNo,
      this.bedRooms,
      this.balconies,
      this.kitchens,
      this.livingRooms,
      this.washrooms,
      this.maidRooms,
      this.driverRooms,
      this.contractID});

  Cities.fromJson(Map<String, dynamic> json) {
    measurementType = json['measurementType'];
    areaSizeSqm = json['areaSizeSqm'];
    areasize = json['areasize'];
    unitID = json['unitID'];
    propertyImageInByte = json['propertyImageInByte'];
    propertyImage = json['propertyImage'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    unitName = json['unitName'];
    unitTypeAR = json['unitTypeAR'];
    unitViewAR = json['unitViewAR'];
    unitRefNo = json['unitRefNo'];
    unitNo = json['unitNo'];
    unitCategory = json['unitCategory'];
    unitCategoryAR = json['unitCategoryAR'];
    landlord = json['landlord'];
    landlordAR = json['landlordAR'];
    unitView = json['unitView'];
    unitType = json['unitType'];
    currentRent = json['currentRent'];
    floorNo = json['floorNo'];
    bedRooms = json['bedRooms'];
    balconies = json['balconies'];
    kitchens = json['kitchens'];
    livingRooms = json['livingRooms'];
    washrooms = json['washrooms'];
    maidRooms = json['maidRooms'];
    driverRooms = json['driverRooms'];
    contractID = json['contractID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['measurementType'] = this.measurementType;
    data['areaSizeSqm'] = this.areaSizeSqm;
    data['areasize'] = this.areasize;
    data['unitID'] = this.unitID;
    data['propertyImageInByte'] = this.propertyImageInByte;
    data['propertyImage'] = this.propertyImage;
    data['propertyName'] = this.propertyName;
    data['propertyNameAR'] = this.propertyNameAR;
    data['unitName'] = this.unitName;
    data['unitTypeAR'] = this.unitTypeAR;
    data['unitViewAR'] = this.unitViewAR;
    data['unitRefNo'] = this.unitRefNo;
    data['unitNo'] = this.unitNo;
    data['unitCategory'] = this.unitCategory;
    data['unitCategoryAR'] = this.unitCategoryAR;
    data['landlord'] = this.landlord;
    data['landlordAR'] = this.landlordAR;
    data['unitView'] = this.unitView;
    data['unitType'] = this.unitType;
    data['currentRent'] = this.currentRent;
    data['floorNo'] = this.floorNo;
    data['bedRooms'] = this.bedRooms;
    data['balconies'] = this.balconies;
    data['kitchens'] = this.kitchens;
    data['livingRooms'] = this.livingRooms;
    data['washrooms'] = this.washrooms;
    data['maidRooms'] = this.maidRooms;
    data['driverRooms'] = this.driverRooms;
    data['contractID'] = this.contractID;
    return data;
  }
}
