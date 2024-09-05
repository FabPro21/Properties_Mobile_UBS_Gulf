class AmcDropDownModel {
  String? statusCode;
  String? status;
  List<AmcData>? amcData;

  AmcDropDownModel({this.statusCode, this.status, this.amcData});

  AmcDropDownModel.fromJson(Map<String?, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    if (json['amcData'] != null) {
      amcData = <AmcData>[];
      json['amcData'].forEach((v) {
        amcData!.add(new AmcData.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    if (this.amcData != null) {
      data['amcData'] = this.amcData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AmcData {
  int? id;
  String? name;

  AmcData({this.id, this.name});

  AmcData.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
