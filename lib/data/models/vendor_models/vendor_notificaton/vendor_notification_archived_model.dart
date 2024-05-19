// To parse this JSON data, do
//
//     final vendorNotificationArchivedModel = vendorNotificationArchivedModelFromJson(jsonString);

import 'dart:convert';

VendorNotificationArchivedModel vendorNotificationArchivedModelFromJson(String str) => VendorNotificationArchivedModel.fromJson(json.decode(str));

String vendorNotificationArchivedModelToJson(VendorNotificationArchivedModel data) => json.encode(data.toJson());

class VendorNotificationArchivedModel {
    VendorNotificationArchivedModel({
        this.status,
        this.statusCode,
        this.message,
    });

    String status;
    String statusCode;
    String message;

    factory VendorNotificationArchivedModel.fromJson(Map<String, dynamic> json) => VendorNotificationArchivedModel(
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
