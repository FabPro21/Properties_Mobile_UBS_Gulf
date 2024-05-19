// To parse this JSON data, do
//
//     final notificationFiles = notificationFilesFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

NotificationFiles notificationFilesFromJson(String str) =>
    NotificationFiles.fromJson(json.decode(str));

String notificationFilesToJson(NotificationFiles data) =>
    json.encode(data.toJson());

class NotificationFiles {
  NotificationFiles({
    this.status,
    this.record,
  });

  String status;
  List<Record> record;

  factory NotificationFiles.fromJson(Map<String, dynamic> json) =>
      NotificationFiles(
        status: json["status"],
        record:
            List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "record": List<dynamic>.from(record.map((x) => x.toJson())),
      };
}

class Record {
  Record({this.fileId, this.fileName, this.uploadOn});

  int fileId;
  String fileName;
  RxBool downloading = false.obs;
  String uploadOn;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
      fileId: json["fileid"],
      fileName: json['fileSource'],
      uploadOn: json["uploadOn"]);

  Map<String, dynamic> toJson() => {
        "fileId": fileId,
      };
}
