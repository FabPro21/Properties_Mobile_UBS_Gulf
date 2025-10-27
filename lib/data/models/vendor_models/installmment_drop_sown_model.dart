class InstallmentDropDownModel {
  String? statusCode;
  String? status;
  List<InstallmentData>? installmentData;

  InstallmentDropDownModel(
      {this.statusCode, this.status, this.installmentData});

  InstallmentDropDownModel.fromJson(Map<String?, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    if (json['installmentData'] != null) {
      installmentData = <InstallmentData>[];
      json['installmentData'].forEach((v) {
        installmentData!.add(InstallmentData.fromJson(v));
      });
    }else{
      installmentData = [];
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    if (installmentData != null) {
      data['installmentData'] =
          installmentData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InstallmentData {
  int? id;
  String? name;
  int? instNo;
  dynamic balance;
  dynamic netAmount;
  dynamic invoiceAmount;

  InstallmentData({this.id, this.name, this.instNo});

  InstallmentData.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
    instNo = json['instNo'];
    balance = json['balance'];
    netAmount = json['netAmount'];
    invoiceAmount = json['invoiceAmount'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['instNo'] = instNo;
    data['balance'] = instNo;
    data['netAmount'] = instNo;
    data['invoiceAmount'] = instNo;
    return data;
  }
}
