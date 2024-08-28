// To parse this JSON data, do
//
//     final publicLocationModel = publicLocationModelFromJson(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as Am;

PublicLocationModel publicLocationModelFromJson(String? str) =>
    PublicLocationModel.fromJson(json.decode(str!));

String? publicLocationModelToJson(PublicLocationModel data) =>
    json.encode(data.toJson());

class PublicLocationModel {
  PublicLocationModel({
    this.status,
    this.locationVm,
    this.message,
  });

  String? status;
  List<LocationVm>? locationVm;
  String? message;

  factory PublicLocationModel.fromJson(Map<String?, dynamic> json) =>
      PublicLocationModel(
        status: json["status"],
        locationVm: List<LocationVm>.from(
            json["locationVm"].map((x) => LocationVm.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "locationVm": List<dynamic>.from(locationVm!.map((x) => x.toJson())),
        "message": message,
      };
}

class LocationVm {
  LocationVm(
      {this.title,
      this.titleAr,
      this.cellNumber,
      this.officeTiming,
      this.address,
      this.description,
      this.latLog,
      this.lat,
      this.lng,
      this.descriptionAr,
      this.cameraPosition,
      this.cameraPositionAm});

  String? title;
  String? titleAr;
  String? cellNumber;
  String? officeTiming;
  String? address;
  String? description;
  String? latLog;
  double? lat;
  double? lng;
  String? descriptionAr;
  CameraPosition? cameraPosition;
  Am.CameraPosition? cameraPositionAm;

  factory LocationVm.fromJson(Map<String?, dynamic> json) {
    List<String?> latlan = json["latLog"].toString().contains(';')
        ? json["latLog"].split(';')
        : json["latLog"].split(',');

    // List<String?> latlan = json["latLog"].split(',');

    CameraPosition position;
    Am.CameraPosition positionAm;
    double lat1;
    double lng1;
    if (latlan.length >= 2) {
      position = CameraPosition(
        target: LatLng(double.parse(latlan[0]!), double.parse(latlan[1]!)),
        zoom: 8,
      );
      positionAm = Am.CameraPosition(
        target: Am.LatLng(double.parse(latlan[0]!), double.parse(latlan[1]!)),
        zoom: 8,
      );
      lat1 = double.parse(latlan[0]!);
      lng1 = double.parse(latlan[1]!);
    } else {
      position = CameraPosition(
        target: LatLng(23.4241, 53.8478),
        zoom: 8,
      );
      positionAm = Am.CameraPosition(
        target: Am.LatLng(23.4241, 53.8478),
        zoom: 8,
      );
      lat1 = 23.4241;
      lng1 = 53.8478;
    }

    return LocationVm(
        title: json["title"],
        titleAr: json["titleAR"],
        cellNumber: json["cellNumber"],
        officeTiming: json["officeTiming"],
        address: json["address"],
        description: json["description"],
        latLog: json["latLog"],
        descriptionAr: json["descriptionAR"],
        cameraPosition: position,
        cameraPositionAm: positionAm,
        lat: lat1,
        lng: lng1);
  }

  Map<String?, dynamic> toJson() => {
        "title": title,
        "titleAR": titleAr,
        "cellNumber": cellNumber,
        "officeTiming": officeTiming,
        "address": address,
        "description": description,
        "latLog": latLog,
        "descriptionAR": descriptionAr,
      };
}
