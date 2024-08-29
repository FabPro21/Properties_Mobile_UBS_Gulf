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
        installmentData!.add(new InstallmentData.fromJson(v));
      });
    }else{
      installmentData = [];
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    if (this.installmentData != null) {
      data['installmentData'] =
          this.installmentData!.map((v) => v.toJson()).toList();
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
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['instNo'] = this.instNo;
    data['balance'] = this.instNo;
    data['netAmount'] = this.instNo;
    data['invoiceAmount'] = this.instNo;
    return data;
  }
}
