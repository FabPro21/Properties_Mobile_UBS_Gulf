// To parse this JSON data, do
//
//     final landLordFaqsQuestionsModel = landLordFaqsQuestionsModelFromJson(jsonString);

import 'dart:convert';

LandLordFaqsQuestionsModel landLordFaqsQuestionsModelFromJson(String? str) =>
    LandLordFaqsQuestionsModel.fromJson(json.decode(str!));

String? landLordFaqsQuestionsModelToJson(LandLordFaqsQuestionsModel data) =>
    json.encode(data.toJson());

class LandLordFaqsQuestionsModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  LandLordFaqsQuestionsModel({this.statusCode, this.message, this.data});

  LandLordFaqsQuestionsModel.fromJson(Map<String?, dynamic> json) {
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
  String? title;
  String? titleAR;
  String? description;
  String? descriptionAR;

  Data({this.title, this.titleAR, this.description, this.descriptionAR});

  Data.fromJson(Map<String?, dynamic> json) {
    title = json['title'];
    titleAR = json['titleAR'];
    description = json['description'];
    descriptionAR = json['descriptionAR'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['title'] = this.title;
    data['titleAR'] = this.titleAR;
    data['description'] = this.description;
    data['descriptionAR'] = this.descriptionAR;
    return data;
  }
}
