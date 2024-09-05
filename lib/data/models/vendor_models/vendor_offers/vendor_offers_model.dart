// To parse this JSON data, do
//
//     final vendorOffersModel = vendorOffersModelFromJson(jsonString);

import 'dart:convert';

VendorOffersModel vendorOffersModelFromJson(String? str) => VendorOffersModel.fromJson(json.decode(str!));

String? vendorOffersModelToJson(VendorOffersModel data) => json.encode(data.toJson());

class VendorOffersModel {
    VendorOffersModel({
        this.statsus,
        this.record,
    });

    String? statsus;
    List<Record>? record;

    factory VendorOffersModel.fromJson(Map<String?, dynamic> json) => VendorOffersModel(
        statsus: json["statsus"],
        record: List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
    );

    Map<String?, dynamic> toJson() => {
        "statsus": statsus,
        "record": List<dynamic>.from(record!.map((x) => x.toJson())),
    };
}

class Record {
    Record({
        this.offerid,
        this.title,
        this.titleAr,
        this.validateFrom,
        this.validateTo,
    });

    int? offerid;
    String? title;
    String? titleAr;
    String? validateFrom;
    String? validateTo;

    factory Record.fromJson(Map<String?, dynamic> json) => Record(
        offerid: json["offerid"],
        title: json["title"],
        titleAr: json["titleAr"],
        validateFrom: json["validateFrom"],
        validateTo: json["validateTo"],
    );

    Map<String?, dynamic> toJson() => {
        "offerid": offerid,
        "title": title,
        "titleAr": titleAr,
        "validateFrom": validateFrom,
        "validateTo": validateTo,
    };
}
