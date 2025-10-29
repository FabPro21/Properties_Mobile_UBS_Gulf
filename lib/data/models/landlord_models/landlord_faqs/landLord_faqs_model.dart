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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
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
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['categoryId'] = categoryId;
    data['title'] = title;
    data['titleAR'] = titleAR;
    return data;
  }
}
