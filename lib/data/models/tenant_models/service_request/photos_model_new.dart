// To parse this JSON data, do
//
//     final getphotosModel = getphotosModelFromJson(jsonString);

import 'dart:convert';

GetphotosModel getphotosModelFromJson(String str) => GetphotosModel.fromJson(json.decode(str));

String getphotosModelToJson(GetphotosModel data) => json.encode(data.toJson());

class GetphotosModel {
    GetphotosModel({
        this.status,
        this.path,
        this.photoId,
    });

    String status;
    List<String> path;
    List<int> photoId;

    factory GetphotosModel.fromJson(Map<String, dynamic> json) => GetphotosModel(
        status: json["status"],
        path: List<String>.from(json["path"].map((x) => x)),
        photoId: List<int>.from(json["photoId"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "path": List<dynamic>.from(path.map((x) => x)),
        "photoId": List<dynamic>.from(photoId.map((x) => x)),
    };
}
