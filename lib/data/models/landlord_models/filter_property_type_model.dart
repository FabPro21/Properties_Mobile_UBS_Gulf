import 'dart:convert';

GetLandLordPropertiesTypesModel landlordPropertyModelFromJson(String str) =>
    GetLandLordPropertiesTypesModel.fromJson(json.decode(str));

String landlordPropertyModelToJson(GetLandLordPropertiesTypesModel data) =>
    json.encode(data.toJson());

class GetLandLordPropertiesTypesModel {
  String status;
  List<PropertyType> propertyType;
  String message;

  GetLandLordPropertiesTypesModel(
      {this.status, this.propertyType, this.message});

  GetLandLordPropertiesTypesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['propertyType'] != null) {
      propertyType = <PropertyType>[];
      json['propertyType'].forEach((v) {
        propertyType.add(new PropertyType.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.propertyType != null) {
      data['propertyType'] = this.propertyType.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class PropertyType {
  String propertyType;
  int propertyTypeID;
  String propertyTypeAR;

  PropertyType({this.propertyType, this.propertyTypeID, this.propertyTypeAR});

  PropertyType.fromJson(Map<String, dynamic> json) {
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
