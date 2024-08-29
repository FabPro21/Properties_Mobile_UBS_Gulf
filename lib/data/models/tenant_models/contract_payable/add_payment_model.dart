// To parse this JSON data, do
//
//     final addPaymentModel = addPaymentModelFromJson(jsonString);

import 'dart:convert';

AddPaymentModel addPaymentModelFromJson(String? str) =>
    AddPaymentModel.fromJson(json.decode(str!));

String? addPaymentModelToJson(AddPaymentModel data) =>
    json.encode(data.toJson());

class AddPaymentModel {
  AddPaymentModel({
    this.detailList,
  });

  List<DetailList>? detailList = [];

  factory AddPaymentModel.fromJson(Map<String?, dynamic> json) =>
      AddPaymentModel(
        detailList: List<DetailList>.from(
            json["DetailList"].map((x) => DetailList.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "DetailList": List<dynamic>.from(detailList!.map((x) => x.toJson())),
      };
}

class DetailList {
  DetailList({
    this.paymentId,
    this.vatOnRentContractId,
    this.vatOnChargeId,
    this.contractId,
    this.paymentMethodId,
    this.contractchargeId,
    this.title,
    this.aramexAddress,
    this.selfDelivery,
    this.description,
    this.type,
    this.amount,
  });

  int? paymentId;
  int? vatOnRentContractId;
  int? vatOnChargeId;
  int? contractId;
  int? paymentMethodId;
  int? contractchargeId;
  String? title;
  String? aramexAddress;
  String? selfDelivery;
  String? description;
  String? type;
  double? amount;

  factory DetailList.fromJson(Map<String?, dynamic> json) => DetailList(
        paymentId: json["PaymentID"],
        vatOnRentContractId: json["VatOnRentContractId"],
        vatOnChargeId: json["VATOnChargeID"],
        contractId: json["ContractId"],
        paymentMethodId: json["PaymentMethodId"],
        contractchargeId: json["ContractchargeID"],
        title: json["Title"],
        aramexAddress: json["AramexAddress"],
        selfDelivery: json["SelfDelivery"],
        description: json["Description"],
        type: json["Type"],
        amount: json["Amount"].toDouble(),
      );

  Map<String?, dynamic> toJson() => {
        "PaymentID": paymentId,
        "VatOnRentContractId": vatOnRentContractId,
        "VATOnChargeID": vatOnChargeId,
        "ContractId": contractId,
        "PaymentMethodId": paymentMethodId,
        "ContractchargeID": contractchargeId,
        "Title": title,
        "AramexAddress": aramexAddress,
        "SelfDelivery": selfDelivery,
        "Description": description,
        "Type": type,
        "Amount": amount,
      };
}
