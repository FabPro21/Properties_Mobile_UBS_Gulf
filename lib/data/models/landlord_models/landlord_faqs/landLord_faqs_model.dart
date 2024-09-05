// To parse this JSON data, do
//
//     final landLordFaqsModel = landLordFaqsModelFromJson(jsonString);

import 'dart:convert';

LandLordFaqsModel landLordFaqsModelFromJson(String? str) =>
    LandLordFaqsModel.fromJson(json.decode(str!));

String? landLordFaqsModelToJson(LandLordFaqsModel data) =>
    json.encode(data.toJson());

class LandLordFaqsModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  LandLordFaqsModel({this.statusCode, this.message, this.data});

  LandLordFaqsModel.fromJson(Map<String?, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? categoryId;
  String? title;
  String? titleAR;

  Data({this.categoryId, this.title, this.titleAR});

  Data.fromJson(Map<String?, dynamic> json) {
    categoryId = json['categoryId'];
    title = json['title'];
    titleAR = json['titleAR'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['categoryId'] = this.categoryId;
    data['title'] = this.title;
    data['titleAR'] = this.titleAR;
    return data;
  }
}
