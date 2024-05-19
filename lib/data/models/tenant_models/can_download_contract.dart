// To parse this JSON data, do
//
//     final canDownloadContract = canDownloadContractFromJson(jsonString);

import 'dart:convert';

CanDownloadContract canDownloadContractFromJson(String str) =>
    CanDownloadContract.fromJson(json.decode(str));

String canDownloadContractToJson(CanDownloadContract data) =>
    json.encode(data.toJson());

class CanDownloadContract {
  CanDownloadContract(
      {this.canDownload, this.message, this.status, this.messageAR});

  String canDownload;
  String message;
  String status;
  String messageAR;

  factory CanDownloadContract.fromJson(Map<String, dynamic> json) =>
      CanDownloadContract(
          canDownload: json["canDownload"],
          message: json["message"],
          status: json["status"],
          messageAR: json["messageAR"]);

  Map<String, dynamic> toJson() => {
        "canDownload": canDownload,
        "message": message,
        "status": status,
      };
}
