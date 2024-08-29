class LandlordDownloadReportModel {
  String? base64;
  String? extension;
  String? name;
  String? message;

  LandlordDownloadReportModel({this.base64, this.extension, this.message});

  LandlordDownloadReportModel.fromJson(Map<String?, dynamic> json) {
    base64 = json['base64'];
    extension = json['extension'];
    name = json['name'];
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['base64'] = this.base64;
    data['extension'] = this.extension;
    data['name'] = this.name;
    data['message'] = this.message;
    return data;
  }
}
