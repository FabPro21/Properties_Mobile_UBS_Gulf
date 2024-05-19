// To parse this JSON data, do
//
//     final getDocsModel = getDocsModelFromJson(jsonString);

import 'dart:convert';

import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
import 'package:get/get.dart';

GetDocsModel getDocsModelFromJson(String str) =>
    GetDocsModel.fromJson(json.decode(str));

class GetDocsModel {
  GetDocsModel({this.docs, this.caseStageInfo, this.responseMessage,this.responseMessageAR});
  List<DocFile> docs;
  CaseStageInfo caseStageInfo;
  String responseMessage;
  String responseMessageAR;

  factory GetDocsModel.fromJson(Map<String, dynamic> json) => GetDocsModel(
      docs: List<DocFile>.from(json["record"].map((x) => DocFile.fromJson(x))),
      caseStageInfo: CaseStageInfo.fromJson(json["caseStageInfo"]),
      responseMessage: json["responseMessage"],
      responseMessageAR: json["responseMessageAR"]
      );
}

class CaseStageInfo {
  CaseStageInfo({
    this.dueActionid,
    this.stageId,
  });

  int dueActionid;
  RxInt stageId;

  factory CaseStageInfo.fromJson(Map<String, dynamic> json) {
    RxInt stageId = 0.obs;
    stageId.value = json["stageId"] ?? 0;
    return CaseStageInfo(
      dueActionid: json["dueActionid"],
      stageId: stageId,
    );
  }

  Map<String, dynamic> toJson() => {
        "dueActionid": dueActionid,
        "stageId": stageId,
      };
}
