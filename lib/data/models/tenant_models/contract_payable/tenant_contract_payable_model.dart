import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

TenantContractPayableModel tenantContractPayableModelFromJson(String str) =>
    TenantContractPayableModel.fromJson(json.decode(str));

String tenantContractPayableModelToJson(TenantContractPayableModel data) =>
    json.encode(data.toJson());

class TenantContractPayableModel {
  TenantContractPayableModel(
      {this.statusCode,
      this.status,
      this.message,
      this.contractPayable,
      this.additionalCharges,
      this.vatCharges,
      this.vatOnRent});
  String statusCode;
  String status;
  String message;
  List<AdditionalCharge> contractPayable;
  List<AdditionalCharge> additionalCharges;
  List<AdditionalCharge> vatCharges;
  List<AdditionalCharge> vatOnRent;

  factory TenantContractPayableModel.fromJson(Map<String, dynamic> json) {
    return TenantContractPayableModel(
      statusCode: json["statusCode"],
      status: json["status"],
      message: json["message"],
      contractPayable: List<AdditionalCharge>.from(
          json["contractPayable"].map((x) => AdditionalCharge.fromJson(x))),
      additionalCharges: List<AdditionalCharge>.from(
          json["additionalCharges"].map((x) => AdditionalCharge.fromJson(x))),
      vatCharges: List<AdditionalCharge>.from(
          json["vatOnCharges"].map((x) => AdditionalCharge.fromJson(x))),
      vatOnRent: List<AdditionalCharge>.from(
          json["vatOnRent"].map((x) => AdditionalCharge.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "contractPayable":
            List<dynamic>.from(contractPayable.map((x) => x.toJson())),
        "additionalCharges":
            List<dynamic>.from(additionalCharges.map((x) => x.toJson())),
      };
}

class AdditionalCharge {
  AdditionalCharge(
      {this.contractId,
      this.contractno,
      this.payment,
      this.paidAmount,
      this.paymentNo,
      this.type,
      this.installments,
      this.contractChargeId,
      this.paymentId,
      this.paymentDate,
      this.balance,
      this.balanceFormatted});

  int contractId;
  String contractno;
  double payment;
  dynamic paidAmount;
  String paymentNo;
  String type;
  int installments;
  int contractChargeId;
  int paymentId;
  double balance;
  String balanceFormatted;
  String paymentDate;
  RxBool isChecked = false.obs;
  RxInt paymentMethod = 1.obs;
  RxBool chequeSelected = false.obs;
  Uint8List chequeFile;
  String filePath;

  factory AdditionalCharge.fromJson(Map<String, dynamic> json) {
    final amountFormat = NumberFormat('#,##0.00', 'AR');
    String balanceFormatted = amountFormat.format(json["balance"] ?? 0);
    return AdditionalCharge(
        contractId: json["contractID"],
        contractno: json["contractno"],
        payment: json["paymentValue"],
        paidAmount: json["paidAmount"] == null ? null : json["paidAmount"],
        paymentNo: json["paymentNo"] == null ? null : json["paymentNo"],
        type: json["type"],
        installments: json["installments"],
        contractChargeId: json['contractchargeID'],
        paymentId: json['paymentID'],
        balance: json["balance"],
        balanceFormatted: balanceFormatted,
        paymentDate: json["paymentDate"]);
  }

  Map<String, dynamic> toJson() => {
        "contractID": contractId,
        "contractno": contractno,
        "paidAmount": paidAmount == null ? null : paidAmount,
        "paymentNo": paymentNo == null ? null : paymentNo,
        "type": type,
        "installments": installments,
        "contractchargeID": contractChargeId,
        "paymentID": paymentId
      };
}
