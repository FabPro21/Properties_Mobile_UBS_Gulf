class LpoDropDownModel {
  String? statusCode;
  String? status;
  List<Lpos>? lpos;

  LpoDropDownModel({this.statusCode, this.status, this.lpos});

  LpoDropDownModel.fromJson(Map<String?, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    if (json['lpos'] != null) {
      lpos = <Lpos>[];
      json['lpos'].forEach((v) {
        lpos!.add(new Lpos.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    if (this.lpos != null) {
      data['lpos'] = this.lpos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lpos {
  int? id;
  String? name;
  dynamic balance;
  dynamic netAmount;
  dynamic invoiceAmount;

  Lpos({this.id, this.name});

  Lpos.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
    balance = json['balance'];
    netAmount = json['netAmount'];
    invoiceAmount = json['invoiceAmount'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['balance'] = this.balance;
    data['netAmount'] = this.netAmount;
    data['invoiceAmount'] = this.invoiceAmount;
    return data;
  }
}
