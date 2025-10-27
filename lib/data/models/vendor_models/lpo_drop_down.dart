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
        lpos!.add(Lpos.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    if (lpos != null) {
      data['lpos'] = lpos!.map((v) => v.toJson()).toList();
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
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['balance'] = balance;
    data['netAmount'] = netAmount;
    data['invoiceAmount'] = invoiceAmount;
    return data;
  }
}
