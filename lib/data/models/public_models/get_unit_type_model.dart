// To parse this JSON data, do
//
//     final getUnitTypeModel = getUnitTypeModelFromJson(jsonString);

import 'dart:convert';

GetUnitTypeModel getUnitTypeModelFromJson(String? str) =>
    GetUnitTypeModel.fromJson(json.decode(str!));

String? getUnitTypeModelToJson(GetUnitTypeModel data) =>
    json.encode(data.toJson());

class GetUnitTypeModel {
  GetUnitTypeModel({
    this.statusCode,
    this.status,
    this.message,
    this.unitTypes,
  });

  String? statusCode;
  String? status;
  String? message;
  UnitTypes? unitTypes;

  factory GetUnitTypeModel.fromJson(Map<String?, dynamic> json) =>
      GetUnitTypeModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        unitTypes: UnitTypes.fromJson(json["unitTypes"]),
      );

  Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "unitTypes": unitTypes!.toJson(),
      };
}

class UnitTypes {
  UnitTypes({
    this.unitTypes,
    this.showArea,
  });

  List<UnitType>? unitTypes;
  bool? showArea;

  factory UnitTypes.fromJson(Map<String?, dynamic> json) => UnitTypes(
        unitTypes: List<UnitType>.from(
            json["unitTypes"].map((x) => UnitType.fromJson(x))),
        showArea: json["showArea"],
      );

  Map<String?, dynamic> toJson() => {
        "unitTypes": List<dynamic>.from(unitTypes!.map((x) => x.toJson())),
        "showArea": showArea,
      };
}

class UnitType {
  UnitType({
    this.unitTypeName,
    this.unitTypeNameAR,
  });

  String? unitTypeName;
  String? unitTypeNameAR;

  factory UnitType.fromJson(Map<String?, dynamic> json) => UnitType(
        unitTypeName: json["unitTypeName"],
        unitTypeNameAR: json["unitTypeNameAR"],
      );

  Map<String?, dynamic> toJson() => {
        "unitTypeName": unitTypeName,
        "unitTypeNameAR": unitTypeNameAR,
      };
}






// // To parse this JSON data, do
// //
// //     final getUnitTypeModel = getUnitTypeModelFromJson(jsonString);

// import 'dart:convert';

// GetUnitTypeModel getUnitTypeModelFromJson(String? str) =>
//     GetUnitTypeModel.fromJson(json.decode(str));

// String? getUnitTypeModelToJson(GetUnitTypeModel data) =>
//     json.encode(data.toJson());

// class GetUnitTypeModel {
//   GetUnitTypeModel({
//     this.statusCode,
//     this.status,
//     this.message,
//     this.unitTypes,
//   });

//   String? statusCode;
//   String? status;
//   String? message;
//   List<UnitType> unitTypes;

//   factory GetUnitTypeModel.fromJson(Map<String?, dynamic> json) =>
//       GetUnitTypeModel(
//         statusCode: json["statusCode"],
//         status: json["status"],
//         message: json["message"],
//         unitTypes: List<UnitType>.from(
//             json["unitType"].map((x) => UnitType.fromJson(x))),
//       );

//   Map<String?, dynamic> toJson() => {
//         "statusCode": statusCode,
//         "status": status,
//         "message": message,
//         "unitType": List<dynamic>.from(unitTypes.map((x) => x.toJson())),
//       };
// }

// class UnitType {
//   UnitType({
//     this.unitTypeID,
//     this.unitType,
//     this.unitTypeAR,
//   });

//   int unitTypeID;
//   String? unitType;
//   String? unitTypeAR;

//   factory UnitType.fromJson(Map<String?, dynamic> json) => UnitType(
//         unitTypeID: json["unitTypeID"],
//         unitType: json["unitType"],
//         unitTypeAR: json["unitTypeAR"],
//       );

//   Map<String?, dynamic> toJson() => {
//         "propertyCategoryID": unitTypeID,
//         "unitType": unitType,
//         "propertyCategoryAR": unitTypeAR,
//       };
// }
