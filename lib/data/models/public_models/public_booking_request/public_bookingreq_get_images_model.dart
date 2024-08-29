// To parse this JSON data, do
//
//     final publicBookingReqGetImageModel = publicBookingReqGetImageModelFromJson(jsonString);

import 'dart:convert';

PublicBookingReqGetImageModel publicBookingReqGetImageModelFromJson(String? str) => PublicBookingReqGetImageModel.fromJson(json.decode(str!));

String? publicBookingReqGetImageModelToJson(PublicBookingReqGetImageModel data) => json.encode(data.toJson());

class PublicBookingReqGetImageModel {
    PublicBookingReqGetImageModel({
        this.status,
        this.bytes,
        this.description,
        this.path,
    });

    String? status;
    String? bytes;
    String? description;
    String? path;

    factory PublicBookingReqGetImageModel.fromJson(Map<String?, dynamic> json) => PublicBookingReqGetImageModel(
        status: json["status"],
        bytes: json["bytes"],
        description: json["description"],
        path: json["path"],
    );

    Map<String?, dynamic> toJson() => {
        "status": status,
        "bytes": bytes,
        "description": description,
        "path": path,
    };
}
