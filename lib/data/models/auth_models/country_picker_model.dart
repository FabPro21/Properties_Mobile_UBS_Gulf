// To parse this JSON data, do
//
//     final countryPickerModel = countryPickerModelFromJson(jsonString);

import 'dart:convert';

CountryPickerModel countryPickerModelFromJson(String str) =>
    CountryPickerModel.fromJson(json.decode(str));

String countryPickerModelToJson(CountryPickerModel data) =>
    json.encode(data.toJson());

class CountryPickerModel {
  CountryPickerModel({
    this.statusCode,
    this.status,
    this.countries,
    this.message,
  });

  String statusCode;
  String status;
  List<Country> countries;
  String message;

  factory CountryPickerModel.fromJson(Map<String, dynamic> json) =>
      CountryPickerModel(
        statusCode: json["statusCode"],
        status: json["status"],
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
        "message": message,
      };
}

class Country {
  Country({
    this.countryId,
    this.countryName,
    this.countryCode,
    this.dialingCode,
    this.flag,
  });

  int countryId;
  String countryName;
  String countryCode;
  String dialingCode;
  String flag;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryId: json["countryId"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
        dialingCode: json["dialingCode"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "countryId": countryId,
        "countryName": countryName,
        "countryCode": countryCode,
        "dialingCode": dialingCode,
        "flag": flag,
      };
}
