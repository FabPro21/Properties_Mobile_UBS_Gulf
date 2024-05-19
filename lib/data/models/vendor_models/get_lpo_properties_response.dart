import 'dart:convert';

class GetLpoPropertiesResponse {
  GetLpoPropertiesResponse({
    this.statusCode,
    this.status,
    this.message,
    this.dashboardPropertiess,
  });

  String statusCode;
  String status;
  String message;
  List<DashboardPropertiess> dashboardPropertiess;

  factory GetLpoPropertiesResponse.fromRawJson(String str) =>
      GetLpoPropertiesResponse.fromJson(json.decode(str));

  factory GetLpoPropertiesResponse.fromJson(Map<String, dynamic> json) =>
      GetLpoPropertiesResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        dashboardPropertiess: List<DashboardPropertiess>.from(
            json["dashboardPropertiess"]
                .map((x) => DashboardPropertiess.fromJson(x))),
      );
}

class DashboardPropertiess {
  DashboardPropertiess({
    this.propertyName,
    this.amount,
    this.unitId,
    this.propertyImage,
    this.buildingRefNo,
    this.referenceNo,
    this.lpoDate,
    this.deliveryDate,
  });

  String propertyName;
  dynamic amount;
  int unitId;
  String propertyImage;
  String buildingRefNo;
  String referenceNo;
  String lpoDate;
  String deliveryDate;

  factory DashboardPropertiess.fromRawJson(String str) =>
      DashboardPropertiess.fromJson(json.decode(str));

  factory DashboardPropertiess.fromJson(Map<String, dynamic> json) =>
      DashboardPropertiess(
        propertyName: json["propertyName"],
        amount: json["amount"],
        unitId: json["unitID"],
        propertyImage: json["propertyImage"],
        buildingRefNo: json["buildingRefNo"],
        referenceNo: json["referenceNo"],
        lpoDate: json["lpoDate"],
        deliveryDate: json["deliveryDate"],
      );
}
