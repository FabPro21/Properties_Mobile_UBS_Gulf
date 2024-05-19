import 'dart:convert';

GetLandLordCategoryModel landlordCategoryModelFromJson(String str) =>
    GetLandLordCategoryModel.fromJson(json.decode(str));

String landlordCategoryModelToJson(GetLandLordCategoryModel data) =>
    json.encode(data.toJson());

class GetLandLordCategoryModel {
  String status;
  List<ProppertyCategoris> proppertyCategoris;
  String message;

  GetLandLordCategoryModel(
      {this.status, this.proppertyCategoris, this.message});

  GetLandLordCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['proppertyCategoris'] != null) {
      proppertyCategoris = <ProppertyCategoris>[];
      json['proppertyCategoris'].forEach((v) {
        proppertyCategoris.add(new ProppertyCategoris.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.proppertyCategoris != null) {
      data['proppertyCategoris'] =
          this.proppertyCategoris.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ProppertyCategoris {
  int propertyCategoryID;
  String propertyCategory;
  String propertyCategoryAR;
  String propertyCategoryCode;

  ProppertyCategoris(
      {this.propertyCategoryID,
      this.propertyCategory,
      this.propertyCategoryAR,
      this.propertyCategoryCode});

  ProppertyCategoris.fromJson(Map<String, dynamic> json) {
    propertyCategoryID = json['propertyCategoryID'];
    propertyCategory = json['propertyCategory'];
    propertyCategoryAR = json['propertyCategoryAR'];
    propertyCategoryCode = json['propertyCategoryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['propertyCategoryID'] = this.propertyCategoryID;
    data['propertyCategory'] = this.propertyCategory;
    data['propertyCategoryAR'] = this.propertyCategoryAR;
    data['propertyCategoryCode'] = this.propertyCategoryCode;
    return data;
  }
}
