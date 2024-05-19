// To parse this JSON data, do
//
//     final getContractStatusModel = getContractStatusModelFromJson(jsonString);

import 'dart:convert';

GetContractLandLordStatusModel getContractStatusModelFromJson(String str) =>
    GetContractLandLordStatusModel.fromJson(json.decode(str));

String getContractStatusModelToJson(GetContractLandLordStatusModel data) =>
    json.encode(data.toJson());

class GetContractLandLordStatusModel {
  int statusCode;
  String message;
  List<Data> data;

  GetContractLandLordStatusModel({this.statusCode, this.message, this.data});

  GetContractLandLordStatusModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String contractTypeID;
  String contractType;
  String contractTypeAR;

  Data({this.contractTypeID, this.contractType, this.contractTypeAR});

  Data.fromJson(Map<String, dynamic> json) {
    contractTypeID = json['contractTypeID'];
    contractType = json['contractType'];
    contractTypeAR = json['contractTypeAR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contractTypeID'] = this.contractTypeID;
    data['contractType'] = this.contractType;
    data['contractTypeAR'] = this.contractTypeAR;
    return data;
  }
}
