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
        propertyEmirate!.add(PropertyEmirate.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['status'] = status;
    if (propertyEmirate != null) {
      data['propertyEmirate'] =
          propertyEmirate!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
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
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['emirateID'] = emirateID;
    data['emirateName'] = emirateName;
    data['emirateNameAR'] = emirateNameAR;
    return data;
  }
}
