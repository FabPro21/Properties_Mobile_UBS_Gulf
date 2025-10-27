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
        propertyUnitDetails!.add(PropertyUnitDetails.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['status'] = status;
    if (propertyUnitDetails != null) {
      data['propertyUnitDetails'] =
          propertyUnitDetails!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
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
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['propertyImage'] = propertyImage;
    data['unitView'] = unitView;
    data['unitViewAR'] = unitViewAR;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['propertyName'] = propertyName;
    data['propertyNameAR'] = propertyNameAR;
    data['address'] = address;
    data['addressAR'] = addressAR;
    data['bedRooms'] = bedRooms;
    data['noofWashrooms'] = noofWashrooms;
    data['areaSize'] = areaSize;
    data['measurementType'] = measurementType;
    data['landlordName'] = landlordName;
    data['unitType'] = unitType;
    data['unitTypeAR'] = unitTypeAR;
    data['unitCategoryName'] = unitCategoryName;
    data['unitCategoryNameAR'] = unitCategoryNameAR;
    data['unitRefNo'] = unitRefNo;
    data['unitName'] = unitName;
    data['noofKitchens'] = noofKitchens;
    data['maidRooms'] = maidRooms;
    data['noofLivingRooms'] = noofLivingRooms;
    data['noofBalconies'] = noofBalconies;
    data['propertyID'] = propertyID;
    data['unitID'] = unitID;
    data['measurementTypeAR'] = measurementTypeAR;
    return data;
  }
}
