import 'dart:convert';

VendorOffersDetailsModel vendorOffersDetailsModelFromJson(String? str) =>
    VendorOffersDetailsModel.fromJson(json.decode(str!));

String? vendorOffersDetailsModelToJson(VendorOffersDetailsModel data) =>
    json.encode(data.toJson());

class VendorOffersDetailsModel {
  VendorOffersDetailsModel({
    this.statsus,
    this.record,
    this.offerProperties,
  });

  String? statsus;
  Record? record;
  List<OfferProperty>? offerProperties;

  factory VendorOffersDetailsModel.fromJson(Map<String?, dynamic> json) =>
      VendorOffersDetailsModel(
        statsus: json["statsus"],
        record: Record.fromJson(json["record"]),
        offerProperties: List<OfferProperty>.from(
            json["offerProperties"].map((x) => OfferProperty.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "statsus": statsus,
        "record": record!.toJson(),
        "offerProperties":
            List<dynamic>.from(offerProperties!.map((x) => x.toJson())),
      };
}

class OfferProperty {
  OfferProperty({
    this.propertyId,
    this.propertyName,
    this.propertyNameAr,
  });

  int? propertyId;
  String? propertyName;
  String? propertyNameAr;

  factory OfferProperty.fromJson(Map<String?, dynamic> json) => OfferProperty(
        propertyId: json["propertyID"],
        propertyName: json["propertyName"] ?? "",
        propertyNameAr: json["propertyNameAR"] ?? '',
      );

  Map<String?, dynamic> toJson() => {
        "propertyID": propertyId,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
      };
}

class Record {
  Record({
    this.offerid,
    this.title,
    this.titleAr,
    this.validateFrom,
    this.validateTo,
    this.description,
    this.desriptionAr,
  });

  int? offerid;
  String? title;
  String? titleAr;
  String? validateFrom;
  String? validateTo;
  String? description;
  dynamic desriptionAr;

  factory Record.fromJson(Map<String?, dynamic> json) => Record(
        offerid: json["offerid"],
        title: json["title"],
        titleAr: json["titleAr"],
        validateFrom: json["validateFrom"],
        validateTo: json["validateTo"],
        description: json["description"],
        desriptionAr: json["desriptionAR"],
      );

  Map<String?, dynamic> toJson() => {
        "offerid": offerid,
        "title": title,
        "titleAr": titleAr,
        "validateFrom": validateFrom,
        "validateTo": validateTo,
        "description": description,
        "desriptionAR": desriptionAr,
      };
}
