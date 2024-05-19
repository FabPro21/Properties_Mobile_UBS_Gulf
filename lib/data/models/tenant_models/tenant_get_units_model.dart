// // To parse this JSON data, do
// //
// //     final getUnitsModel = getUnitsModelFromJson(jsonString);

// import 'dart:convert';

// GetUnitsModel getUnitsModelFromJson(String str) =>
//     GetUnitsModel.fromJson(json.decode(str));

// String getUnitsModelToJson(GetUnitsModel data) => json.encode(data.toJson());

// class GetUnitsModel {
//   GetUnitsModel({
//     this.status,
//     this.units,
//     this.message,
//   });

//   String status;
//   List<Unit> units;
//   String message;

//   factory GetUnitsModel.fromJson(Map<String, dynamic> json) => GetUnitsModel(
//         status: json["status"],
//         units: List<Unit>.from(json["units"].map((x) => Unit.fromJson(x))),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "units": List<dynamic>.from(units.map((x) => x.toJson())),
//         "message": message,
//       };
// }

// class Unit {
//   Unit({
//     this.referenceNo,
//     this.unitNo,
//     this.startDate,
//     this.endDate,
//     this.propertyImage,
//     this.propertyName,
//   });

//   dynamic referenceNo;
//   dynamic unitNo;
//   dynamic startDate;
//   dynamic endDate;
//   PropertyImage propertyImage;
//   String propertyName;

//   factory Unit.fromJson(Map<String, dynamic> json) => Unit(
//         referenceNo: json["referenceNo"],
//         unitNo: json["unitNo"],
//         startDate: json["startDate"],
//         endDate: json["endDate"],
//         propertyImage: propertyImageValues.map[json["propertyImage"]],
//         propertyName: json["propertyName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "referenceNo": referenceNo,
//         "unitNo": unitNo,
//         "startDate": startDate,
//         "endDate": endDate,
//         "propertyImage": propertyImageValues.reverse[propertyImage],
//         "propertyName": propertyName,
//       };
// }

// enum PropertyImage { NOTIMAGE_GIF }

// final propertyImageValues =
//     EnumValues({"Notimage.gif": PropertyImage.NOTIMAGE_GIF});

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
