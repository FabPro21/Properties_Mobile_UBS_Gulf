class LandLordUnitDetailModel {
  String? status;
  List<PropertyUnitDetails>? propertyUnitDetails;
  String? message;

  LandLordUnitDetailModel(
      {this.status, this.propertyUnitDetails, this.message});

  LandLordUnitDetailModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    if (json['propertyUnitDetails'] != null) {
      propertyUnitDetails = <PropertyUnitDetails>[];
      json['propertyUnitDetails'].forEach((v) {
        propertyUnitDetails!.add(new PropertyUnitDetails.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['status'] = this.status;
    if (this.propertyUnitDetails != null) {
      data['propertyUnitDetails'] =
          this.propertyUnitDetails!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class PropertyUnitDetails {
  String? propertyImage;
  dynamic unitView;
  dynamic unitViewAR;
  String? longitude;
  String? latitude;
  String? propertyName;
  String? propertyNameAR;
  String? address;
  String? addressAR;
  int? bedRooms;
  int? noofWashrooms;
  String? areaSize;
  String? measurementType;
  dynamic landlordName;
  String? unitType;
  String? unitTypeAR;
  String? unitCategoryName;
  String? unitCategoryNameAR;
  String? unitRefNo;
  String? unitName;
  int? noofKitchens;
  int? maidRooms;
  int? noofLivingRooms;
  int? noofBalconies;
  int? propertyID;
  int? unitID;
  int? measurementTypeAR;

  PropertyUnitDetails(
      {this.propertyImage,
      this.unitView,
      this.unitViewAR,
      this.longitude,
      this.latitude,
      this.propertyName,
      this.propertyNameAR,
      this.address,
      this.addressAR,
      this.bedRooms,
      this.noofWashrooms,
      this.areaSize,
      this.measurementType,
      this.landlordName,
      this.unitType,
      this.unitTypeAR,
      this.unitCategoryName,
      this.unitCategoryNameAR,
      this.unitRefNo,
      this.unitName,
      this.noofKitchens,
      this.maidRooms,
      this.noofLivingRooms,
      this.noofBalconies,
      this.propertyID,
      this.unitID,
      this.measurementTypeAR});

  PropertyUnitDetails.fromJson(Map<String?, dynamic> json) {
    propertyImage = json['propertyImage'];
    unitView = json['unitView'];
    unitViewAR = json['unitViewAR'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    address = json['address'];
    addressAR = json['addressAR'];
    bedRooms = json['bedRooms'];
    noofWashrooms = json['noofWashrooms'];
    areaSize = json['areaSize'];
    measurementType = json['measurementType'];
    landlordName = json['landlordName'];
    unitType = json['unitType'];
    unitTypeAR = json['unitTypeAR'];
    unitCategoryName = json['unitCategoryName'];
    unitCategoryNameAR = json['unitCategoryNameAR'];
    unitRefNo = json['unitRefNo'];
    unitName = json['unitName'];
    noofKitchens = json['noofKitchens'];
    maidRooms = json['maidRooms'];
    noofLivingRooms = json['noofLivingRooms'];
    noofBalconies = json['noofBalconies'];
    propertyID = json['propertyID'];
    unitID = json['unitID'];
    measurementTypeAR = json['measurementTypeAR'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['propertyImage'] = this.propertyImage;
    data['unitView'] = this.unitView;
    data['unitViewAR'] = this.unitViewAR;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['propertyName'] = this.propertyName;
    data['propertyNameAR'] = this.propertyNameAR;
    data['address'] = this.address;
    data['addressAR'] = this.addressAR;
    data['bedRooms'] = this.bedRooms;
    data['noofWashrooms'] = this.noofWashrooms;
    data['areaSize'] = this.areaSize;
    data['measurementType'] = this.measurementType;
    data['landlordName'] = this.landlordName;
    data['unitType'] = this.unitType;
    data['unitTypeAR'] = this.unitTypeAR;
    data['unitCategoryName'] = this.unitCategoryName;
    data['unitCategoryNameAR'] = this.unitCategoryNameAR;
    data['unitRefNo'] = this.unitRefNo;
    data['unitName'] = this.unitName;
    data['noofKitchens'] = this.noofKitchens;
    data['maidRooms'] = this.maidRooms;
    data['noofLivingRooms'] = this.noofLivingRooms;
    data['noofBalconies'] = this.noofBalconies;
    data['propertyID'] = this.propertyID;
    data['unitID'] = this.unitID;
    data['measurementTypeAR'] = this.measurementTypeAR;
    return data;
  }
}
