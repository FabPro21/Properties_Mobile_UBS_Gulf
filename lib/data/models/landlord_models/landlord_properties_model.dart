// To parse this JSON data, do
//
//     final landlordPropertiesModel = landlordPropertiesModelFromJson(jsonString);

import 'dart:convert';

LandlordPropertiesModel landlordPropertiesModelFromJson(String str) =>
    LandlordPropertiesModel.fromJson(json.decode(str));

String landlordPropertiesModelToJson(LandlordPropertiesModel data) =>
    json.encode(data.toJson());

class LandlordPropertiesModel {
  String status;
  int totalRecord;
  List<ServiceRequests> serviceRequests;
  String message;

  LandlordPropertiesModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  LandlordPropertiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecord = json['totalRecord'];
    if (json['serviceRequests'] != null) {
      serviceRequests = <ServiceRequests>[];
      json['serviceRequests'].forEach((v) {
        serviceRequests.add(new ServiceRequests.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalRecord'] = this.totalRecord;
    if (this.serviceRequests != null) {
      data['serviceRequests'] =
          this.serviceRequests.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ServiceRequests {
  int propertyID;
  dynamic buildingRefNo;
  String buildingNumber;
  String propertyName;
  String propertyNameAR;
  String plotNumber;
  String roadName;
  String roadNameAR;
  String sector;
  String sectorAR;
  String propertyType;
  String propertyTypeAR;
  String propertyCategory;
  String propertyCategoryAR;
 dynamic emirateName;
 dynamic emirateNameAR;
 dynamic noofResidentialFlat;
 dynamic noofCommercialFlat;
 dynamic noofStores;
 dynamic noofParkinglot;
  int totalRecord;

  ServiceRequests(
      {this.propertyID,
      this.buildingRefNo,
      this.buildingNumber,
      this.propertyName,
      this.propertyNameAR,
      this.plotNumber,
      this.roadName,
      this.roadNameAR,
      this.sector,
      this.sectorAR,
      this.propertyType,
      this.propertyTypeAR,
      this.propertyCategory,
      this.propertyCategoryAR,
      this.emirateName,
      this.emirateNameAR,
      this.noofResidentialFlat,
      this.noofCommercialFlat,
      this.noofStores,
      this.noofParkinglot,
      this.totalRecord});

  ServiceRequests.fromJson(Map<String, dynamic> json) {
    propertyID = json['propertyID'];
    buildingRefNo = json['buildingRefNo'];
    buildingNumber = json['buildingNumber'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    plotNumber = json['plotNumber'];
    roadName = json['roadName'];
    roadNameAR = json['roadNameAR'];
    sector = json['sector'];
    sectorAR = json['sectorAR'];
    propertyType = json['propertyType'];
    propertyTypeAR = json['propertyTypeAR'];
    propertyCategory = json['propertyCategory'];
    propertyCategoryAR = json['propertyCategoryAR'];
    emirateName = json['emirateName'];
    emirateNameAR = json['emirateNameAR'];
    noofResidentialFlat = json['noofResidentialFlat'];
    noofCommercialFlat = json['noofCommercialFlat'];
    noofStores = json['noofStores'];
    noofParkinglot = json['noofParkinglot'];
    totalRecord = json['totalRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['propertyID'] = this.propertyID;
    data['buildingRefNo'] = this.buildingRefNo;
    data['buildingNumber'] = this.buildingNumber;
    data['propertyName'] = this.propertyName;
    data['propertyNameAR'] = this.propertyNameAR;
    data['plotNumber'] = this.plotNumber;
    data['roadName'] = this.roadName;
    data['roadNameAR'] = this.roadNameAR;
    data['sector'] = this.sector;
    data['sectorAR'] = this.sectorAR;
    data['propertyType'] = this.propertyType;
    data['propertyTypeAR'] = this.propertyTypeAR;
    data['propertyCategory'] = this.propertyCategory;
    data['propertyCategoryAR'] = this.propertyCategoryAR;
    data['emirateName'] = this.emirateName;
    data['emirateNameAR'] = this.emirateNameAR;
    data['noofResidentialFlat'] = this.noofResidentialFlat;
    data['noofCommercialFlat'] = this.noofCommercialFlat;
    data['noofStores'] = this.noofStores;
    data['noofParkinglot'] = this.noofParkinglot;
    data['totalRecord'] = this.totalRecord;
    return data;
  }
}
