// To parse this JSON data, do
//
//     final vendorNotificationReadModel = vendorNotificationReadModelFromJson(jsonString);

import 'dart:convert';

VendorNotificationReadModel vendorNotificationReadModelFromJson(String str) => VendorNotificationReadModel.fromJson(json.decode(str));

String vendorNotificationReadModelToJson(VendorNotificationReadModel data) => json.encode(data.toJson());

class VendorNotificationReadModel {
    VendorNotificationReadModel({
        this.status,
        this.statusCode,
        this.message,
    });

    String status;
    String statusCode;
    String message;

    factory VendorNotificationReadModel.fromJson(Map<String, dynamic> json) => VendorNotificationReadModel(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
    };
}
