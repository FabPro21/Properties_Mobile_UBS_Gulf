// To parse this JSON data, do
//
//     final tenantRegisterPaymentModel = tenantRegisterPaymentModelFromJson(jsonString);

import 'dart:convert';

TenantRegisterPaymentModel tenantRegisterPaymentModelFromJson(String str) =>
    TenantRegisterPaymentModel.fromJson(json.decode(str));

String tenantRegisterPaymentModelToJson(TenantRegisterPaymentModel data) =>
    json.encode(data.toJson());

class TenantRegisterPaymentModel {
  TenantRegisterPaymentModel({
    this.totalAmount,
    this.contractId,
    this.contractNo,
    this.userId,
    this.detailList,
  });

  double totalAmount;
  int contractId;
  String contractNo;
  int userId;
  List<DetailList> detailList;

  factory TenantRegisterPaymentModel.fromJson(Map<String, dynamic> json) =>
      TenantRegisterPaymentModel(
        totalAmount: json["totalAmount"],
        contractId: json["contractId"],
        contractNo: json["contractNo"],
        userId: json["userId"],
        detailList: List<DetailList>.from(
            json["detailList"].map((x) => DetailList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "contractId": contractId,
        "contractNo": contractNo,
        "userId": userId,
        "detailList": List<dynamic>.from(detailList.map((x) => x.toJson())),
      };
}

class DetailList {
  DetailList(
      {this.title,
      this.description,
      this.amount,
      this.chargeId = 0,
      this.paymentId = 0,
      this.vatOnRentContractId = 0,
      this.vatOnChargeId = 0,
      this.paymentSettingId = 0});

  String title;
  String description;
  double amount;
  int chargeId;
  int paymentId;
  int vatOnRentContractId;
  int vatOnChargeId;
  int paymentSettingId;

  factory DetailList.fromJson(Map<String, dynamic> json) => DetailList(
      title: json["title"],
      description: json["description"],
      amount: json["amount"],
      chargeId: json["contractchargeID"],
      paymentId: json["paymentID"]);

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "amount": amount,
        "ContractchargeID": chargeId,
        "PaymentID": paymentId,
        "VatOnRentContractId": vatOnRentContractId,
        "VATOnChargeID": vatOnChargeId,
        "paymentSettingId": paymentSettingId
      };
}
