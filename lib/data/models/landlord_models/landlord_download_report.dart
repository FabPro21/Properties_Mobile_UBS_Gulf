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
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['base64'] = base64;
    data['extension'] = extension;
    data['name'] = name;
    data['message'] = message;
    return data;
  }
}
