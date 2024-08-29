// To parse this JSON data, do
//
//     final getContractFinancialTermsModel = getContractFinancialTermsModelFromJson(jsonString);

import 'dart:convert';

GetContractFinancialTermsModel getContractFinancialTermsModelFromJson(
        String? str) =>
    GetContractFinancialTermsModel.fromJson(json.decode(str!));

String? getContractFinancialTermsModelToJson(
        GetContractFinancialTermsModel data) =>
    json.encode(data.toJson());

class GetContractFinancialTermsModel {
  GetContractFinancialTermsModel({
    this.status,
    this.statusCode,
    this.contractFinancialTerms,
    this.paid,
    this.message,
  });

  String? status;
  String? statusCode;
  List<ContractFinancialTerm>? contractFinancialTerms;
  Paid? paid;
  String? message;

  factory GetContractFinancialTermsModel.fromJson(Map<String?, dynamic> json) =>
      GetContractFinancialTermsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        contractFinancialTerms: List<ContractFinancialTerm>.from(
            json["contractFinancialTerms"]
                .map((x) => ContractFinancialTerm.fromJson(x))),
        paid: Paid.fromJson(json["paid"]),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "contractFinancialTerms":
            List<dynamic>.from(contractFinancialTerms!.map((x) => x.toJson())),
        "paid": paid!.toJson(),
        "message": message,
      };
}

class ContractFinancialTerm {
  ContractFinancialTerm({
    this.paymentTermId,
    this.contractId,
    this.paymentDate,
    this.amount,
  });

  dynamic paymentTermId;
  dynamic contractId;
  String? paymentDate;
  dynamic amount;

  factory ContractFinancialTerm.fromJson(Map<String?, dynamic> json) =>
      ContractFinancialTerm(
        paymentTermId: json["paymentTermID"],
        contractId: json["contractID"],
        paymentDate: json["paymentDate"],
        amount: json["amount"],
      );

  Map<String?, dynamic> toJson() => {
        "paymentTermID": paymentTermId,
        "contractID": contractId,
        "paymentDate": paymentDate,
        "amount": amount,
      };
}

class Paid {
  Paid({
    this.paid,
  });

  dynamic paid;

  factory Paid.fromJson(Map<String?, dynamic> json) => Paid(
        paid: json["paid"],
      );

  Map<String?, dynamic> toJson() => {
        "paid": paid,
      };
}
