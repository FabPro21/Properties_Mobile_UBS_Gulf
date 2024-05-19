
class DownloadChequeModel {
  String status;
  String cheque;
  String chequeName;

  DownloadChequeModel({this.status, this.cheque, this.chequeName});

  DownloadChequeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    cheque = json['cheque'];
    chequeName = json['chequeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['cheque'] = this.cheque;
    data['chequeName'] = this.chequeName;
    return data;
  }
}
