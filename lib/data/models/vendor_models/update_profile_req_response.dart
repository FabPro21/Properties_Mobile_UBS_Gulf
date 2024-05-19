// To parse this JSON data, do
//
//     final updateProfileRequestResponse = updateProfileRequestResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfileRequestResponse updateProfileRequestResponseFromJson(String str) =>
    UpdateProfileRequestResponse.fromJson(json.decode(str));

String updateProfileRequestResponseToJson(UpdateProfileRequestResponse data) =>
    json.encode(data.toJson());

class UpdateProfileRequestResponse {
  UpdateProfileRequestResponse({
    this.status,
    this.caseNo,
    this.message,
    this.document,
  });

  String status;
  int caseNo;
  String message;
  List<Document> document;

  factory UpdateProfileRequestResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequestResponse(
        status: json["status"],
        caseNo: json["caseNo"],
        message: json["message"],
        document: List<Document>.from(
            json["document"].map((x) => Document.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "caseNo": caseNo,
        "message": message,
        "document": List<dynamic>.from(document.map((x) => x.toJson())),
      };
}

class Document {
  Document({
    this.name,
    this.documentTypeId,
  });

  String name;
  int documentTypeId;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        name: json["name"],
        documentTypeId: json["documentTypeId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "documentTypeId": documentTypeId,
      };
}
