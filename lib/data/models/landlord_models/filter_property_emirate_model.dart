import 'dart:convert';

GetLandLordEmirateModel landlordEmirateModelFromJson(String? str) =>
    GetLandLordEmirateModel.fromJson(json.decode(str!));

String? landlordEmirateModelToJson(GetLandLordEmirateModel data) =>
    json.encode(data.toJson());

class GetLandLordEmirateModel {
  String? status;
  List<PropertyEmirate>? propertyEmirate;
  String? message;

  GetLandLordEmirateModel({this.status, this.propertyEmirate, this.message});

  GetLandLordEmirateModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    if (json['propertyEmirate'] != null) {
      propertyEmirate = <PropertyEmirate>[];
      json['propertyEmirate'].forEach((v) {
        propertyEmirate!.add(new PropertyEmirate.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['status'] = this.status;
    if (this.propertyEmirate != null) {
      data['propertyEmirate'] =
          this.propertyEmirate!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class PropertyEmirate {
  int? emirateID;
  String? emirateName;
  String? emirateNameAR;

  PropertyEmirate({this.emirateID, this.emirateName, this.emirateNameAR});

  PropertyEmirate.fromJson(Map<String?, dynamic> json) {
    emirateID = json['emirateID'];
    emirateName = json['emirateName'];
    emirateNameAR = json['emirateNameAR'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['emirateID'] = this.emirateID;
    data['emirateName'] = this.emirateName;
    data['emirateNameAR'] = this.emirateNameAR;
    return data;
  }
}
