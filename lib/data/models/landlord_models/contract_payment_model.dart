// To parse this JSON data, do
//
//     final contractPaymentModel = contractPaymentModelFromJson(jsonString);

import 'dart:convert';

import 'package:fap_properties/data/models/landlord_models/contract_cheque_model.dart';
import 'package:get/get.dart';

ContractPaymentModelLandlord contractPaymentModelFromJson(String? str) =>
    ContractPaymentModelLandlord.fromJson(json.decode(str!));

String? contractPaymentModelToJson(ContractPaymentModelLandlord data) =>
    json.encode(data.toJson());

class ContractPaymentModelLandlord {
  ContractPaymentModelLandlord({
    this.status,
    this.statusCode,
    this.payments,
    this.message,
  });

  String? status;
  String? statusCode;
  List<Payment>? payments;
  String? message;

  factory ContractPaymentModelLandlord.fromJson(Map<String?, dynamic> json) =>
      ContractPaymentModelLandlord(
        status: json["status"],
        statusCode: json["statusCode"],
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "payments": List<dynamic>.from(payments!.map((x) => x.toJson())),
        "message": message,
      };
}

class Payment {
  Payment(
      {this.transactionId,
      this.contractId,
      this.paymentDate,
      this.propertyName,
      this.propertyNameAr,
      this.propertyNumber,
      this.receiptNo,
      this.accountNo,
      this.accountTitle,
      this.amount,
      this.paymentType,
      this.paymentTypeAr,
      this.contractDate,
      this.tenant,
      this.tenantAr,
      this.unitNo,
      this.contractNo,
      this.city,
      this.cityAr,
      this.paymentFor,
      this.paymentForAr,
      this.landLord,
      this.contractStatus,
      this.receiptDate});

  dynamic transactionId;
  dynamic contractId;
  String? paymentDate;
  String? propertyName;
  String? propertyNameAr;
  String? propertyNumber;
  String? receiptNo;
  String? accountNo;
  String? accountTitle;
  dynamic amount;
  String? paymentType;
  String? paymentTypeAr;
  String? contractDate;
  String? tenant;
  String? tenantAr;
  String? unitNo;
  String? contractNo;
  String? city;
  String? cityAr;
  String? paymentFor;
  String? paymentForAr;
  String? landLord;
  String? contractStatus;
  String? receiptDate;
  GetContractChequesModelLandlord? cheque;
  RxBool? loadingCheque = false.obs;
  String? errorLoadingCheque = '';
  RxBool? downloadingReceipt = false.obs;

  factory Payment.fromJson(Map<String?, dynamic> json) => Payment(
      transactionId: json["transactionId"],
      contractId: json["contractID"],
      paymentDate: json["paymentDate"],
      propertyName: json["propertyName"],
      propertyNameAr: json["propertyNameAR"],
      propertyNumber: json["propertyNumber"],
      receiptNo: json["receiptNo"],
      accountNo: json["accountNo"],
      accountTitle: json["accountTitle"],
      amount: json["amount"],
      paymentType: json["paymentType"],
      paymentTypeAr: json["paymentTypeAR"],
      contractDate: json["contractDate"],
      tenant: json["tenant"],
      tenantAr: json["tenantAR"],
      unitNo: json["unitNo"],
      contractNo: json["contractNo"],
      city: json["city"],
      cityAr: json["cityAR"],
      paymentFor: json["paymentFor"],
      paymentForAr: json["paymentForAR"],
      landLord: json["landLord"],
      contractStatus: json["contractStatus"] ?? '',
      receiptDate: json['receiptDate'] ?? '');

  Map<String?, dynamic> toJson() => {
        "transactionId": transactionId,
        "contractID": contractId,
        "paymentDate": paymentDate,
        "propertyName": propertyName,
        "propertyNameAR": propertyNameAr,
        "propertyNumber": propertyNumber,
        "receiptNo": receiptNo,
        "accountNo": accountNo,
        "accountTitle": accountTitle,
        "amount": amount,
        "paymentType": paymentType,
        "contractDate": contractDate,
        "tenant": tenant,
        "tenantAR": tenantAr,
        "unitNo": unitNo,
        "contractNo": contractNo,
        "city": city,
        "cityAR": cityAr,
        "paymentFor": paymentFor,
        "landLord": landLord,
      };
}
