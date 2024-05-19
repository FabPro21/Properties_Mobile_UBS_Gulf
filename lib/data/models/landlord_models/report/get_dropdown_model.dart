class GetDropDownModel {
  String status;
  int totalRecord;
  List<ServiceRequests> serviceRequests = [
    ServiceRequests(id: -1, name: '', nameAr: '')
  ];
  String message;

  GetDropDownModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  GetDropDownModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecord = json['totalRecord'];
    if (json['serviceRequests'] != null) {
      serviceRequests = [];
      json['serviceRequests'].forEach((v) {
        serviceRequests.add(new ServiceRequests.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalRecord'] = this.totalRecord;
    if (this.serviceRequests != null) {
      data['serviceRequests'] =
          this.serviceRequests.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ServiceRequests {
  int id;
  String name;
  String nameAr;

  ServiceRequests({this.id, this.name, this.nameAr});

  ServiceRequests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['nameAr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    return data;
  }
}
