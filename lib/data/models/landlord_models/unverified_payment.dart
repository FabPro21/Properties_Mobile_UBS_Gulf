// To parse this JSON data, do
//
//     final unverifiedContractPayments = unverifiedContractPaymentsFromJson(jsonString);

import 'dart:convert';

UnverifiedContractPaymentsLandLord unverifiedLLDContractPaymentsFromJson(String? str) =>
    UnverifiedContractPaymentsLandLord.fromJson(json.decode(str!));

String? unverifiedLLDContractPaymentsToJson(UnverifiedContractPaymentsLandLord data) =>
    json.encode(data.toJson());

class UnverifiedContractPaymentsLandLord {
  UnverifiedContractPaymentsLandLord({
    this.status,
    this.contractPayments,
    this.note,
  });

  String? status;
  List<ContractPayment>? contractPayments;
  String? note;

  factory UnverifiedContractPaymentsLandLord.fromJson(Map<String?, dynamic> json) =>
      UnverifiedContractPaymentsLandLord(
        status: json["status"],
        contractPayments: List<ContractPayment>.from(
            json["contractPayments"].map((x) => ContractPayment.fromJson(x))),
        note: json["note"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "contractPayments":
            List<dynamic>.from(contractPayments!.map((x) => x.toJson())),
        "note": note,
      };
}

class ContractPayment {
  ContractPayment(
      {this.paymentDetailId,
      this.title,
      this.titleAR,
      this.referenceNo,
      this.description,
      this.status,
      this.contractno,
      this.createdOn,
      this.amount,
      this.paymentType,
      this.paymentTypeAR,
      this.chequeNo});

  int? paymentDetailId;
  String? title;
  String? titleAR;
  String? referenceNo;
  String? description;
  String? status;
  String? contractno;
  String? createdOn;
  double? amount;
  String? paymentType;
  String? paymentTypeAR;
  String? chequeNo;

  factory ContractPayment.fromJson(Map<String?, dynamic> json) =>
      ContractPayment(
          paymentDetailId: json["paymentDetailId"],
          title: json["title"],
          titleAR: json["titleAR"],
          referenceNo: json["referenceNo"],
          description: json["description"],
          status: json["status"],
          contractno: json["contractno"],
          createdOn: json["createdOn"],
          amount: json["amount"],
          paymentType: json['paymentType'],
          paymentTypeAR: json['paymentTypeAR'],
          chequeNo: json['chequeNo']);

  Map<String?, dynamic> toJson() => {
        "paymentDetailId": paymentDetailId,
        "title": title,
        "titleAR": titleAR,
        "referenceNo": referenceNo,
        "description": description,
        "status": status,
        "contractno": contractno,
        "createdOn": createdOn,
        "amount": amount,
      };
}
