
class DownloadChequeModel {
  String? status;
  String? cheque;
  String? chequeName;

  DownloadChequeModel({this.status, this.cheque, this.chequeName});

  DownloadChequeModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    cheque = json['cheque'];
    chequeName = json['chequeName'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['status'] = status;
    data['cheque'] = cheque;
    data['chequeName'] = chequeName;
    return data;
  }
}
