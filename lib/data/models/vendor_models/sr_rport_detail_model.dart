class SRReportDetailModel {
  String status;
  Data data;

  SRReportDetailModel({this.status, this.data});

  SRReportDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int fgpCorrectionId;
  String proposedRemedy;
  String description;

  Data({this.fgpCorrectionId, this.proposedRemedy, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    fgpCorrectionId = json['fgpCorrectionId'];
    proposedRemedy = json['proposedRemedy'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fgpCorrectionId'] = this.fgpCorrectionId;
    data['proposedRemedy'] = this.proposedRemedy;
    data['description'] = this.description;
    return data;
  }
}
