import 'dart:convert';

LandlordPropertiesDetailsModel landlordPropertiesDetailsModelFromJson(String str) =>
    LandlordPropertiesDetailsModel.fromJson(json.decode(str));

String landlordPropertiesDetailsModeltoJson(LandlordPropertiesDetailsModel data) =>
    json.encode(data.toJson());

class LandlordPropertiesDetailsModel {
  String status;
  List<PropertyDetails> propertyDetails;
  String message;

  LandlordPropertiesDetailsModel(
      {this.status, this.propertyDetails, this.message});

  LandlordPropertiesDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['propertyDetails'] != null) {
      propertyDetails = <PropertyDetails>[];
      json['propertyDetails'].forEach((v) {
        propertyDetails.add(new PropertyDetails.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.propertyDetails != null) {
      data['propertyDetails'] =
          this.propertyDetails.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class PropertyDetails {
  int propertyID;
  String buildingRefNo;
  String propertyName;
  String propertyNameAR;
  dynamic landlordID;
  String plotNumber;
  String roadName;
  String roadNameAR;
  String sector;
  String sectorAR;
  dynamic propertyLocation;
  dynamic propertyLocationAR;
  dynamic landmark;
  String propertyAddress;
  String propertyAddressAR;
  dynamic plotSize;
  dynamic areaSize;
  dynamic cost;
  dynamic ratePerSqft;
  dynamic constructionDate;
  dynamic age;
  dynamic purchasedDate;
  dynamic purchasedPrice;
  dynamic valuationPrice;
  dynamic valuationDate;
  dynamic propertyStatusID;
  dynamic managementFee;
  dynamic baID;
  dynamic engineerIncharge;
  dynamic engineerInchargeAR;
  dynamic contactPerson;
  dynamic contactPhone;
  dynamic contactMobile;
  dynamic geoCode;
  int noofBlocks;
  int noofFloors;
  dynamic isMizanFloor;
  int noofStores;
  int noofResidentialFlat;
  int noofCommercialFlat;
  int noofParkinglot;
  dynamic parkinglotAvailability;
  dynamic ratePerParkinglot;
  dynamic propertyImage;
  dynamic features;
  dynamic description;
  dynamic lastviewedBy;
  dynamic lastViewedDate;
  dynamic soldStatus;
  dynamic renewalRentPercent;
  dynamic latitude;
  dynamic longitude;
  dynamic electricityMeter;
  dynamic dewAADWEA;
  dynamic waterMeter;
  dynamic handOverDate;
  String relationshipOfProperty;
  dynamic document;
  dynamic securityPhoneNo;
  dynamic isOnHold;
  dynamic totalUnits;
  dynamic engineerCharge;
  dynamic isDIPProperty;
  dynamic isInterCompany;
  dynamic cashUploadType;
  dynamic templateId;
  dynamic approvedForCardPayment;
  String emirateName;
  dynamic emirateNameAR;

  PropertyDetails(
      {this.propertyID,
      this.buildingRefNo,
      this.propertyName,
      this.propertyNameAR,
      this.landlordID,
      this.plotNumber,
      this.roadName,
      this.roadNameAR,
      this.sector,
      this.sectorAR,
      this.propertyLocation,
      this.propertyLocationAR,
      this.landmark,
      this.propertyAddress,
      this.propertyAddressAR,
      this.plotSize,
      this.areaSize,
      this.cost,
      this.ratePerSqft,
      this.constructionDate,
      this.age,
      this.purchasedDate,
      this.purchasedPrice,
      this.valuationPrice,
      this.valuationDate,
      this.propertyStatusID,
      this.managementFee,
      this.baID,
      this.engineerIncharge,
      this.engineerInchargeAR,
      this.contactPerson,
      this.contactPhone,
      this.contactMobile,
      this.geoCode,
      this.noofBlocks,
      this.noofFloors,
      this.isMizanFloor,
      this.noofStores,
      this.noofResidentialFlat,
      this.noofCommercialFlat,
      this.noofParkinglot,
      this.parkinglotAvailability,
      this.ratePerParkinglot,
      this.propertyImage,
      this.features,
      this.description,
      this.lastviewedBy,
      this.lastViewedDate,
      this.soldStatus,
      this.renewalRentPercent,
      this.latitude,
      this.longitude,
      this.electricityMeter,
      this.dewAADWEA,
      this.waterMeter,
      this.handOverDate,
      this.relationshipOfProperty,
      this.document,
      this.securityPhoneNo,
      this.isOnHold,
      this.totalUnits,
      this.engineerCharge,
      this.isDIPProperty,
      this.isInterCompany,
      this.cashUploadType,
      this.templateId,
      this.approvedForCardPayment,
      this.emirateName,
      this.emirateNameAR});

  PropertyDetails.fromJson(Map<String, dynamic> json) {
    propertyID = json['propertyID'];
    buildingRefNo = json['buildingRefNo'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    landlordID = json['landlordID'];
    plotNumber = json['plotNumber'];
    roadName = json['roadName'];
    roadNameAR = json['roadNameAR'];
    sector = json['sector'];
    sectorAR = json['sectorAR'];
    propertyLocation = json['propertyLocation'];
    propertyLocationAR = json['propertyLocationAR'];
    landmark = json['landmark'];
    propertyAddress = json['propertyAddress'];
    propertyAddressAR = json['propertyAddressAR'];
    plotSize = json['plotSize'];
    areaSize = json['areaSize'];
    cost = json['cost'];
    ratePerSqft = json['ratePerSqft'];
    constructionDate = json['constructionDate'];
    age = json['age'];
    purchasedDate = json['purchasedDate'];
    purchasedPrice = json['purchasedPrice'];
    valuationPrice = json['valuationPrice'];
    valuationDate = json['valuationDate'];
    propertyStatusID = json['propertyStatusID'];
    managementFee = json['managementFee'];
    baID = json['baID'];
    engineerIncharge = json['engineerIncharge'];
    engineerInchargeAR = json['engineerInchargeAR'];
    contactPerson = json['contactPerson'];
    contactPhone = json['contactPhone'];
    contactMobile = json['contactMobile'];
    geoCode = json['geoCode'];
    noofBlocks = json['noofBlocks'];
    noofFloors = json['noofFloors'];
    isMizanFloor = json['isMizanFloor'];
    noofStores = json['noofStores'];
    noofResidentialFlat = json['noofResidentialFlat'];
    noofCommercialFlat = json['noofCommercialFlat'];
    noofParkinglot = json['noofParkinglot'];
    parkinglotAvailability = json['parkinglotAvailability'];
    ratePerParkinglot = json['ratePerParkinglot'];
    propertyImage = json['propertyImage'];
    features = json['features'];
    description = json['description'];
    lastviewedBy = json['lastviewedBy'];
    lastViewedDate = json['lastViewedDate'];
    soldStatus = json['soldStatus'];
    renewalRentPercent = json['renewalRentPercent'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    electricityMeter = json['electricityMeter'];
    dewAADWEA = json['dewA_ADWEA'];
    waterMeter = json['waterMeter'];
    handOverDate = json['handOverDate'];
    relationshipOfProperty = json['relationshipOfProperty'];
    document = json['document'];
    securityPhoneNo = json['securityPhoneNo'];
    isOnHold = json['isOnHold'];
    totalUnits = json['totalUnits'];
    engineerCharge = json['engineerCharge'];
    isDIPProperty = json['isDIPProperty'];
    isInterCompany = json['isInterCompany'];
    cashUploadType = json['cashUploadType'];
    templateId = json['templateId'];
    approvedForCardPayment = json['approvedForCardPayment'];
    emirateName = json['emirateName'];
    emirateNameAR = json['emirateNameAR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['propertyID'] = this.propertyID;
    data['buildingRefNo'] = this.buildingRefNo;
    data['propertyName'] = this.propertyName;
    data['propertyNameAR'] = this.propertyNameAR;
    data['landlordID'] = this.landlordID;
    data['plotNumber'] = this.plotNumber;
    data['roadName'] = this.roadName;
    data['roadNameAR'] = this.roadNameAR;
    data['sector'] = this.sector;
    data['sectorAR'] = this.sectorAR;
    data['propertyLocation'] = this.propertyLocation;
    data['propertyLocationAR'] = this.propertyLocationAR;
    data['landmark'] = this.landmark;
    data['propertyAddress'] = this.propertyAddress;
    data['propertyAddressAR'] = this.propertyAddressAR;
    data['plotSize'] = this.plotSize;
    data['areaSize'] = this.areaSize;
    data['cost'] = this.cost;
    data['ratePerSqft'] = this.ratePerSqft;
    data['constructionDate'] = this.constructionDate;
    data['age'] = this.age;
    data['purchasedDate'] = this.purchasedDate;
    data['purchasedPrice'] = this.purchasedPrice;
    data['valuationPrice'] = this.valuationPrice;
    data['valuationDate'] = this.valuationDate;
    data['propertyStatusID'] = this.propertyStatusID;
    data['managementFee'] = this.managementFee;
    data['baID'] = this.baID;
    data['engineerIncharge'] = this.engineerIncharge;
    data['engineerInchargeAR'] = this.engineerInchargeAR;
    data['contactPerson'] = this.contactPerson;
    data['contactPhone'] = this.contactPhone;
    data['contactMobile'] = this.contactMobile;
    data['geoCode'] = this.geoCode;
    data['noofBlocks'] = this.noofBlocks;
    data['noofFloors'] = this.noofFloors;
    data['isMizanFloor'] = this.isMizanFloor;
    data['noofStores'] = this.noofStores;
    data['noofResidentialFlat'] = this.noofResidentialFlat;
    data['noofCommercialFlat'] = this.noofCommercialFlat;
    data['noofParkinglot'] = this.noofParkinglot;
    data['parkinglotAvailability'] = this.parkinglotAvailability;
    data['ratePerParkinglot'] = this.ratePerParkinglot;
    data['propertyImage'] = this.propertyImage;
    data['features'] = this.features;
    data['description'] = this.description;
    data['lastviewedBy'] = this.lastviewedBy;
    data['lastViewedDate'] = this.lastViewedDate;
    data['soldStatus'] = this.soldStatus;
    data['renewalRentPercent'] = this.renewalRentPercent;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['electricityMeter'] = this.electricityMeter;
    data['dewA_ADWEA'] = this.dewAADWEA;
    data['waterMeter'] = this.waterMeter;
    data['handOverDate'] = this.handOverDate;
    data['relationshipOfProperty'] = this.relationshipOfProperty;
    data['document'] = this.document;
    data['securityPhoneNo'] = this.securityPhoneNo;
    data['isOnHold'] = this.isOnHold;
    data['totalUnits'] = this.totalUnits;
    data['engineerCharge'] = this.engineerCharge;
    data['isDIPProperty'] = this.isDIPProperty;
    data['isInterCompany'] = this.isInterCompany;
    data['cashUploadType'] = this.cashUploadType;
    data['templateId'] = this.templateId;
    data['approvedForCardPayment'] = this.approvedForCardPayment;
    data['emirateName'] = this.emirateName;
    data['emirateNameAR'] = this.emirateNameAR;
    return data;
  }
}
