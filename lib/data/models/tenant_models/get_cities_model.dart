// To parse this JSON data, do
//
//     final getCitiesModel = getCitiesModelFromJson(jsonString);

import 'dart:convert';

GetCitiesModel getCitiesModelFromJson(String str) =>
    GetCitiesModel.fromJson(json.decode(str));

String getCitiesModelToJson(GetCitiesModel data) => json.encode(data.toJson());

class GetCitiesModel {
  GetCitiesModel({
    this.status,
    this.cities,
    this.message,
  });

  String status;
  List<City> cities;
  String message;

  factory GetCitiesModel.fromJson(Map<String, dynamic> json) => GetCitiesModel(
        status: json["status"],
        cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
        "message": message,
      };
}

class City {
  City({
    this.cityId,
    this.cityName,
    this.cityNameAr,
  });

  int cityId;
  dynamic cityName;
  dynamic cityNameAr;

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["cityID"],
        cityName: json["cityName"],
        cityNameAr: json["cityNameAR"],
      );

  Map<String, dynamic> toJson() => {
        "cityID": cityId,
        "cityName": cityName,
        "cityNameAR": cityNameAr,
      };
}
