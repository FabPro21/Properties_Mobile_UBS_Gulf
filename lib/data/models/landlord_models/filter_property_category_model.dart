import 'dart:convert';

GetLandLordCategoryModel landlordCategoryModelFromJson(String? str) =>
    GetLandLordCategoryModel.fromJson(json.decode(str!));

String? landlordCategoryModelToJson(GetLandLordCategoryModel data) =>
    json.encode(data.toJson());

class GetLandLordCategoryModel {
  String? status;
  List<ProppertyCategoris>? proppertyCategoris;
  String? message;

  GetLandLordCategoryModel(
      {this.status, this.proppertyCategoris, this.message});

  GetLandLordCategoryModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    if (json['proppertyCategoris'] != null) {
      proppertyCategoris = <ProppertyCategoris>[];
      json['proppertyCategoris'].forEach((v) {
        proppertyCategoris!.add(ProppertyCategoris.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['status'] = status;
    if (proppertyCategoris != null) {
      data['proppertyCategoris'] =
          proppertyCategoris!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ProppertyCategoris {
  int? propertyCategoryID;
  String? propertyCategory;
  String? propertyCategoryAR;
  String? propertyCategoryCode;

  ProppertyCategoris(
      {this.propertyCategoryID,
      this.propertyCategory,
      this.propertyCategoryAR,
      this.propertyCategoryCode});

  ProppertyCategoris.fromJson(Map<String?, dynamic> json) {
    propertyCategoryID = json['propertyCategoryID'];
    propertyCategory = json['propertyCategory'];
    propertyCategoryAR = json['propertyCategoryAR'];
    propertyCategoryCode = json['propertyCategoryCode'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['propertyCategoryID'] = propertyCategoryID;
    data['propertyCategory'] = propertyCategory;
    data['propertyCategoryAR'] = propertyCategoryAR;
    data['propertyCategoryCode'] = propertyCategoryCode;
    return data;
  }
}
