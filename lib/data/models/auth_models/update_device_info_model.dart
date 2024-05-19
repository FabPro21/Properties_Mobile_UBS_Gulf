// To parse this JSON data, do
//
//     final updateDeviceInfoModel = updateDeviceInfoModelFromJson(jsonString);

import 'dart:convert';

UpdateDeviceInfoModel updateDeviceInfoModelFromJson(String str) =>
    UpdateDeviceInfoModel.fromJson(json.decode(str));

String updateDeviceInfoModelToJson(UpdateDeviceInfoModel data) =>
    json.encode(data.toJson());

class UpdateDeviceInfoModel {
  UpdateDeviceInfoModel({
    this.statustCode,
    this.status,
    this.data,
    this.message,
  });

  String statustCode;
  String status;
  Data data;
  String message;

  factory UpdateDeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      UpdateDeviceInfoModel(
        statustCode: json["statustCode"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statustCode": statustCode,
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.deviceName,
    this.deviceToken,
    this.type,
    this.createdOn,
    this.userId,
  });

  String deviceName;
  String deviceToken;
  String type;
  String createdOn;
  int userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deviceName: json["deviceName"],
        deviceToken: json["deviceToken"],
        type: json["type"],
        createdOn: json["createdOn"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "deviceName": deviceName,
        "deviceToken": deviceToken,
        "type": type,
        "createdOn": createdOn,
        "userId": userId,
      };
}
