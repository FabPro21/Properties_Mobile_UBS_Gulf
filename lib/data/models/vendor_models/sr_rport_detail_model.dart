class SRReportDetailModel {
  String? status;
  Data? data;

  SRReportDetailModel({this.status, this.data});

  SRReportDetailModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? fgpCorrectionId;
  String? proposedRemedy;
  String? description;

  Data({this.fgpCorrectionId, this.proposedRemedy, this.description});

  Data.fromJson(Map<String?, dynamic> json) {
    fgpCorrectionId = json['fgpCorrectionId'];
    proposedRemedy = json['proposedRemedy'];
    description = json['description'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['fgpCorrectionId'] = fgpCorrectionId;
    data['proposedRemedy'] = proposedRemedy;
    data['description'] = description;
    return data;
  }
}
