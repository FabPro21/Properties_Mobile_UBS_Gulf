// To parse this JSON data, do
//
//     final outstandingPaymentsModel = outstandingPaymentsModelFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

OutstandingPaymentsModel outstandingPaymentsModelFromJson(String? str) =>
    OutstandingPaymentsModel.fromJson(json.decode(str!));

String? outstandingPaymentsModelToJson(OutstandingPaymentsModel data) =>
    json.encode(data.toJson());

class OutstandingPaymentsModel {
  OutstandingPaymentsModel({
    this.record,
    this.status,
  });

  List<Record>? record;
  String? status;

  factory OutstandingPaymentsModel.fromJson(Map<String?, dynamic> json) =>
      OutstandingPaymentsModel(
        record:
            List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
        status: json["status"],
      );

  Map<String?, dynamic> toJson() => {
        "record": List<dynamic>.from(record!.map((x) => x.toJson())),
        "status": status,
      };
}

class Record {
  Record(
      {this.type,
      this.title,
      this.paymentMode,
      this.cheque,
      this.amount,
      this.amountFormatted,
      this.description,
      this.paymentDate,
      this.paymentSettingId,
      this.contractId,
      this.defaultpaymentmethodtype,
      this.contractchargeId,
      this.contractPaymentId,
      this.vatOnRentContractId,
      this.vatOnChargeId,
      this.aramexAddress,
      this.selfDelivery,
      this.confirmed,
      this.titleAr,
      this.chequeNo,
      this.isRejected,
      this.acceptPaymentType});

  String? type;
  String? title;
  String? paymentMode;
  String? cheque;
  double? amount;
  String? amountFormatted;
  String? description;
  String? paymentDate;
  int? paymentSettingId;
  int? contractId;
  // int paymentMethodId;
  int? contractchargeId;
  int? contractPaymentId;
  int? vatOnRentContractId;
  int? vatOnChargeId;
  String? selfDelivery;
  int? confirmed;
  String? chequeNo = '';
  bool? isRejected;
  int? acceptPaymentType;

  RxBool isChecked = false.obs;
  RxInt? defaultpaymentmethodtype = 0.obs;
  RxBool updatingPaymentMethod = false.obs;
  bool errorUpdatingPaymentMethod = false;
  RxBool uploadingCheque = false.obs;
  bool errorUploadingCheque = false;
  RxBool downloadingCheque = false.obs;
  bool errorDownloadingCheque = false;
  RxBool forceUploadCheque = false.obs;
  RxBool errorRemovingCheque = false.obs;
  RxBool removingCheque = false.obs;
  RxBool errorChequeNo = false.obs;
  Uint8List? chequeFile;
  String? filePath;
  String? aramexAddress;
  String? titleAr;

  factory Record.fromJson(Map<String?, dynamic> json) {
    final amountFormat = NumberFormat('#,##0.00', 'AR');
    String? amountFormatted = amountFormat.format(json["amount"] ?? 0);
    int paymentMethodId = json["paymentMethodId"];
    RxInt paymentMethodId2 = paymentMethodId.obs;
    return Record(
        type: json["type"] ?? "",
        title: json["title"] ?? '',
        paymentMode: json["paymentMode"],
        cheque: json["cheque"],
        amount: json["amount"],
        amountFormatted: amountFormatted,
        description: json["description"],
        paymentDate: json["paymentDate"],
        paymentSettingId: json["paymentSettingId"],
        contractId: json["contractId"],
        defaultpaymentmethodtype: paymentMethodId2,
        contractchargeId: json["contractchargeID"],
        contractPaymentId: json["contractPaymentID"],
        vatOnRentContractId: json["vatOnRentContractId"],
        vatOnChargeId: json["vatOnChargeId"],
        aramexAddress: json["aramexAddress"] ?? '',
        selfDelivery: json["selfDelivery"],
        confirmed: json["confirmed"],
        titleAr: json["titleAr"],
        chequeNo: json['chequeNo'] ?? '',
        isRejected: json['isRejected'],
        acceptPaymentType: json['acceptPaymentType']);
  }

  Map<String?, dynamic> toJson() => {
        "type": type,
        "title": title,
        "paymentMode": paymentMode,
        "cheque": cheque,
        "amount": amount,
        "description": description,
        "paymentSettingId": paymentSettingId,
        "contractId": contractId,
        "paymentMethodId": defaultpaymentmethodtype,
        "contractchargeID": contractchargeId,
        "contractPaymentID": contractPaymentId,
        "vatOnRentContractId": vatOnRentContractId,
        "vatOnChargeId": vatOnChargeId,
      };
}


 // Before disable the paymentMethodId
// // To parse this JSON data, do
// //
// //     final outstandingPaymentsModel = outstandingPaymentsModelFromJson(jsonString);

// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// OutstandingPaymentsModel outstandingPaymentsModelFromJson(String? str) =>
//     OutstandingPaymentsModel.fromJson(json.decode(str));

// String? outstandingPaymentsModelToJson(OutstandingPaymentsModel data) =>
//     json.encode(data.toJson());

// class OutstandingPaymentsModel {
//   OutstandingPaymentsModel({
//     this.record,
//     this.status,
//   });

//   List<Record> record;
//   String? status;

//   factory OutstandingPaymentsModel.fromJson(Map<String?, dynamic> json) =>
//       OutstandingPaymentsModel(
//         record:
//             List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
//         status: json["status"],
//       );

//   Map<String?, dynamic> toJson() => {
//         "record": List<dynamic>.from(record.map((x) => x.toJson())),
//         "status": status,
//       };
// }

// class Record {
//   Record(
//       {this.type,
//       this.title,
//       this.paymentMode,
//       this.cheque,
//       this.amount,
//       this.amountFormatted,
//       this.description,
//       this.paymentDate,
//       this.paymentSettingId,
//       this.contractId,
//       this.paymentMethodId,
//       this.contractchargeId,
//       this.contractPaymentId,
//       this.vatOnRentContractId,
//       this.vatOnChargeId,
//       this.aramexAddress,
//       this.selfDelivery,
//       this.confirmed,
//       this.titleAr,
//       this.chequeNo,
//       this.isRejected,
//       this.acceptPaymentType});

//   String? type;
//   String? title;
//   String? paymentMode;
//   String? cheque;
//   double amount;
//   String? amountFormatted;
//   String? description;
//   String? paymentDate;
//   int paymentSettingId;
//   int contractId;
//   // int paymentMethodId;
//   int contractchargeId;
//   int contractPaymentId;
//   int vatOnRentContractId;
//   int vatOnChargeId;
//   String? selfDelivery;
//   int confirmed;
//   String? chequeNo = '';
//   bool isRejected;
//   int acceptPaymentType;

//   RxBool isChecked = false.obs;
//   RxInt paymentMethodId = 0.obs;
//   RxBool updatingPaymentMethod = false.obs;
//   bool errorUpdatingPaymentMethod = false;
//   RxBool uploadingCheque = false.obs;
//   bool errorUploadingCheque = false;
//   RxBool downloadingCheque = false.obs;
//   bool errorDownloadingCheque = false;
//   RxBool forceUploadCheque = false.obs;
//   RxBool errorRemovingCheque = false.obs;
//   RxBool removingCheque = false.obs;
//   RxBool errorChequeNo = false.obs;
//   Uint8List chequeFile;
//   String? filePath;
//   String? aramexAddress;
//   String? titleAr;

//   factory Record.fromJson(Map<String?, dynamic> json) {
//     final amountFormat = NumberFormat('#,##0.00', 'AR');
//     String? amountFormatted = amountFormat.format(json["amount"] ?? 0);
//     int paymentMethodId = json["paymentMethodId"];
//     RxInt paymentMethodId2 = paymentMethodId.obs;
//     return Record(
//         type: json["type"] ?? "",
//         title: json["title"] ?? '',
//         paymentMode: json["paymentMode"],
//         cheque: json["cheque"],
//         amount: json["amount"],
//         amountFormatted: amountFormatted,
//         description: json["description"],
//         paymentDate: json["paymentDate"],
//         paymentSettingId: json["paymentSettingId"],
//         contractId: json["contractId"],
//         paymentMethodId: paymentMethodId2,
//         contractchargeId: json["contractchargeID"],
//         contractPaymentId: json["contractPaymentID"],
//         vatOnRentContractId: json["vatOnRentContractId"],
//         vatOnChargeId: json["vatOnChargeId"],
//         aramexAddress: json["aramexAddress"] ?? '',
//         selfDelivery: json["selfDelivery"],
//         confirmed: json["confirmed"],
//         titleAr: json["titleAr"],
//         chequeNo: json['chequeNo'] ?? '',
//         isRejected: json['isRejected'],
//         acceptPaymentType: json['acceptPaymentType']);
//   }

//   Map<String?, dynamic> toJson() => {
//         "type": type,
//         "title": title,
//         "paymentMode": paymentMode,
//         "cheque": cheque,
//         "amount": amount,
//         "description": description,
//         "paymentSettingId": paymentSettingId,
//         "contractId": contractId,
//         "paymentMethodId": paymentMethodId,
//         "contractchargeID": contractchargeId,
//         "contractPaymentID": contractPaymentId,
//         "vatOnRentContractId": vatOnRentContractId,
//         "vatOnChargeId": vatOnChargeId,
//       };
// }
