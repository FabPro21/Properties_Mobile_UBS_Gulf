// To parse this JSON data, do
//
//     final getVendorAccountsModel = getVendorAccountsModelFromJson(jsonString);

import 'dart:convert';

GetVendorAccountsModel getVendorAccountsModelFromJson(String str) =>
    GetVendorAccountsModel.fromJson(json.decode(str));

String getVendorAccountsModelToJson(GetVendorAccountsModel data) =>
    json.encode(data.toJson());

class GetVendorAccountsModel {
  GetVendorAccountsModel({
    this.statusCode,
    this.status,
    this.message,
    this.accounts,
  });

  String statusCode;
  String status;
  String message;
  List<Account> accounts;

  factory GetVendorAccountsModel.fromJson(Map<String, dynamic> json) =>
      GetVendorAccountsModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        accounts: List<Account>.from(
            json["accounts"].map((x) => Account.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
      };
}

class Account {
  Account({
    this.vendorId,
    this.bankName,
    this.bankNameAr,
    this.accountTitle,
    this.accountTitleAR,
    this.accountNumber,
    this.iban,
    this.swiftCode,
  });

  dynamic vendorId;
  String bankName;
  String bankNameAr;
  String accountTitle;
  String accountTitleAR;
  String accountNumber;
  String iban;
  String swiftCode;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        vendorId: json["vendorId"],
        bankName: json["bankName"],
        bankNameAr: json["bankNameAR"],
        accountTitle: json["accountTitle"],
        accountTitleAR: json["accountTitleAR"],
        accountNumber: json["accountNumber"],
        iban: json["iban"],
        swiftCode: json["swiftCode"],
      );

  Map<String, dynamic> toJson() => {
        "vendorId": vendorId,
        "bankName": bankName,
        "bankNameAR": bankNameAr,
        "accountTitle": accountTitle,
        "accountTitleAR": accountTitleAR,
        "accountNumber": accountNumber,
        "iban": iban,
        "swiftCode": swiftCode,
      };
}
