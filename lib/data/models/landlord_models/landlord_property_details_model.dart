import 'dart:convert';

LandlordPropertiesDetailsModel landlordPropertiesDetailsModelFromJson(String? str) =>
    LandlordPropertiesDetailsModel.fromJson(json.decode(str!));

String? landlordPropertiesDetailsModeltoJson(LandlordPropertiesDetailsModel data) =>
    json.encode(data.toJson());

class LandlordPropertiesDetailsModel {
  String? status;
  List<PropertyDetails>? propertyDetails;
  String? message;

  LandlordPropertiesDetailsModel(
      {this.status, this.propertyDetails, this.message});

  LandlordPropertiesDetailsModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    if (json['propertyDetails'] != null) {
      propertyDetails = <PropertyDetails>[];
      json['propertyDetails'].forEach((v) {
        propertyDetails!.add(PropertyDetails.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['status'] = status;
    if (propertyDetails != null) {
      data['propertyDetails'] =
          propertyDetails!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class PropertyDetails {
  int? propertyID;
  String? buildingRefNo;
  String? propertyName;
  String? propertyNameAR;
  dynamic landlordID;
  String? plotNumber;
  String? roadName;
  String? roadNameAR;
  String? sector;
  String? sectorAR;
  dynamic propertyLocation;
  dynamic propertyLocationAR;
  dynamic landmark;
  String? propertyAddress;
  String? propertyAddressAR;
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
  int? noofBlocks;
  int? noofFloors;
  dynamic isMizanFloor;
  int? noofStores;
  int? noofResidentialFlat;
  int? noofCommercialFlat;
  int? noofParkinglot;
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
  String? relationshipOfProperty;
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
  String? emirateName;
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

  PropertyDetails.fromJson(Map<String?, dynamic> json) {
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

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['propertyID'] = propertyID;
    data['buildingRefNo'] = buildingRefNo;
    data['propertyName'] = propertyName;
    data['propertyNameAR'] = propertyNameAR;
    data['landlordID'] = landlordID;
    data['plotNumber'] = plotNumber;
    data['roadName'] = roadName;
    data['roadNameAR'] = roadNameAR;
    data['sector'] = sector;
    data['sectorAR'] = sectorAR;
    data['propertyLocation'] = propertyLocation;
    data['propertyLocationAR'] = propertyLocationAR;
    data['landmark'] = landmark;
    data['propertyAddress'] = propertyAddress;
    data['propertyAddressAR'] = propertyAddressAR;
    data['plotSize'] = plotSize;
    data['areaSize'] = areaSize;
    data['cost'] = cost;
    data['ratePerSqft'] = ratePerSqft;
    data['constructionDate'] = constructionDate;
    data['age'] = age;
    data['purchasedDate'] = purchasedDate;
    data['purchasedPrice'] = purchasedPrice;
    data['valuationPrice'] = valuationPrice;
    data['valuationDate'] = valuationDate;
    data['propertyStatusID'] = propertyStatusID;
    data['managementFee'] = managementFee;
    data['baID'] = baID;
    data['engineerIncharge'] = engineerIncharge;
    data['engineerInchargeAR'] = engineerInchargeAR;
    data['contactPerson'] = contactPerson;
    data['contactPhone'] = contactPhone;
    data['contactMobile'] = contactMobile;
    data['geoCode'] = geoCode;
    data['noofBlocks'] = noofBlocks;
    data['noofFloors'] = noofFloors;
    data['isMizanFloor'] = isMizanFloor;
    data['noofStores'] = noofStores;
    data['noofResidentialFlat'] = noofResidentialFlat;
    data['noofCommercialFlat'] = noofCommercialFlat;
    data['noofParkinglot'] = noofParkinglot;
    data['parkinglotAvailability'] = parkinglotAvailability;
    data['ratePerParkinglot'] = ratePerParkinglot;
    data['propertyImage'] = propertyImage;
    data['features'] = features;
    data['description'] = description;
    data['lastviewedBy'] = lastviewedBy;
    data['lastViewedDate'] = lastViewedDate;
    data['soldStatus'] = soldStatus;
    data['renewalRentPercent'] = renewalRentPercent;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['electricityMeter'] = electricityMeter;
    data['dewA_ADWEA'] = dewAADWEA;
    data['waterMeter'] = waterMeter;
    data['handOverDate'] = handOverDate;
    data['relationshipOfProperty'] = relationshipOfProperty;
    data['document'] = document;
    data['securityPhoneNo'] = securityPhoneNo;
    data['isOnHold'] = isOnHold;
    data['totalUnits'] = totalUnits;
    data['engineerCharge'] = engineerCharge;
    data['isDIPProperty'] = isDIPProperty;
    data['isInterCompany'] = isInterCompany;
    data['cashUploadType'] = cashUploadType;
    data['templateId'] = templateId;
    data['approvedForCardPayment'] = approvedForCardPayment;
    data['emirateName'] = emirateName;
    data['emirateNameAR'] = emirateNameAR;
    return data;
  }
}
