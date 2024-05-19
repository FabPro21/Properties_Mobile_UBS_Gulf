// To parse this JSON data, do
//
//     final getPropertyTypesModel = getPropertyTypesModelFromJson(jsonString);

import 'dart:convert';

GetLandLordPropertyTypesModel getPropertyTypesModelFromJson(String str) =>
    GetLandLordPropertyTypesModel.fromJson(json.decode(str));

String getPropertyTypesModelToJson(GetLandLordPropertyTypesModel data) =>
    json.encode(data.toJson());

class GetLandLordPropertyTypesModel {
  int statusCode;
  String message;
  List<Data> data;

  GetLandLordPropertyTypesModel({this.statusCode, this.message, this.data});

  GetLandLordPropertyTypesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String propertyType;
  String propertyTypeID;
  String propertyTypeAR;

  Data({this.propertyType, this.propertyTypeID, this.propertyTypeAR});

  Data.fromJson(Map<String, dynamic> json) {
    propertyType = json['propertyType'];
    propertyTypeID = json['propertyTypeID'];
    propertyTypeAR = json['propertyTypeAR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['propertyType'] = this.propertyType;
    data['propertyTypeID'] = this.propertyTypeID;
    data['propertyTypeAR'] = this.propertyTypeAR;
    return data;
  }
}
