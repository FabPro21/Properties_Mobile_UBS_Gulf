// To parse this JSON data, do
//
//     final landlordContractDetailsModel = landlordContractDetailsModelFromJson(jsonString);

import 'dart:convert';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:intl/intl.dart';

LandlordContractDetailsModel landlordContractDetailsModelFromJson(String str) =>
    LandlordContractDetailsModel.fromJson(json.decode(str));

String landlordContractDetailsModelToJson(LandlordContractDetailsModel data) =>
    json.encode(data.toJson());

class LandlordContractDetailsModel {
  LandlordContractDetailsModel({
    this.status,
    this.contract,
    this.message,
  });

  String status;
  Contract contract;
  String message;

  factory LandlordContractDetailsModel.fromJson(Map<String, dynamic> json) =>
      LandlordContractDetailsModel(
        status: json["status"],
        contract: Contract.fromJson(json["contract"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "contract": contract.toJson(),
        "message": message,
      };
}

class Contract {
  Contract(
      {this.contractPosition,
      this.contractPositionName,
      this.propertyTypeId,
      this.propertyStatusId,
      this.isExpire,
      this.isreadyToExpire,
      this.contractId,
      this.contractno,
      this.address,
      this.addressAr,
      this.contractDate,
      this.contractStartDate,
      this.contractEndDate,
      this.rentforstay,
      this.noOfDays,
      this.gracePeriod,
      this.noOfContractYears,
      this.installments,
      this.retention,
      this.otherCharges,
      this.vatCharges,
      this.vatAmount,
      this.unitName,
      this.propertyName,
      this.unitNameAr,
      this.unitPicture,
      this.unitType,
      this.unitTypeAr,
      this.contractStatus,
      this.contractTypeId,
      this.contractStatusAr,
      this.unitNo,
      this.payment,
      this.amountFormatted,
      this.noOfDaysLeft,
      this.noOfDaysPassed,
      this.complete});

  int contractPosition;
  String contractPositionName;
  int propertyTypeId;
  int propertyStatusId;
  int isExpire;
  int isreadyToExpire;
  int contractId;
  String contractno;
  String address;
  String addressAr;
  String contractDate;
  String contractStartDate;
  String contractEndDate;
  dynamic rentforstay;
  int noOfDays;
  int gracePeriod;
  int noOfContractYears;
  int installments;
  String retention;
  dynamic otherCharges;
  dynamic vatCharges;
  dynamic vatAmount;
  String unitName;
  dynamic propertyName;
  String unitNameAr;
  String unitPicture;
  String unitType;
  dynamic unitTypeAr;
  String contractStatus;
  int contractTypeId;
  dynamic contractStatusAr;
  String unitNo;
  Payment payment;
  String amountFormatted;

  int noOfDaysLeft;
  int noOfDaysPassed;
  double complete;

  factory Contract.fromJson(Map<String, dynamic> json) {
    DateTime startDate =
        DateFormat('dd-MM-yyyy').parse(json["contractStartDate"]);
    DateTime endDate = DateFormat('dd-MM-yyyy').parse(json["contractEndDate"]);
    DateTime now = DateTime.now();
    int daysLeft = 0;
    int daysPassed = 0;
    double complete = 0;
    int totalDays = json["noOfDays"];
    if (now.compareTo(startDate) < 0) {
      daysLeft = totalDays;
    } else if (now.compareTo(endDate) >= 0) {
      daysPassed = totalDays;
      complete = 1;
    } else {
      daysPassed = now.difference(startDate).inDays + 1;
      daysLeft = totalDays - daysPassed;
      complete = daysPassed / totalDays;
    }
    return Contract(
        contractPosition: json["contractPosition"],
        contractPositionName: json["contractPositionName"],
        propertyTypeId: json["propertyTypeID"],
        propertyStatusId: json["propertyStatusID"],
        isExpire: json["isExpire"],
        isreadyToExpire: json["isreadyToExpire"],
        contractId: json["contractID"],
        contractno: json["contractno"],
        address: json["address"],
        addressAr: json["addressAR"],
        contractDate: json["contractDate"],
        contractStartDate: json["contractStartDate"],
        contractEndDate: json["contractEndDate"],
        rentforstay: json["rentforstay"],
        noOfDays: json["noOfDays"],
        gracePeriod: json["gracePeriod"],
        noOfContractYears: json["noOfContractYears"],
        installments: json["installments"],
        retention: json["retention"],
        otherCharges: json["otherCharges"],
        vatCharges: json["vatCharges"],
        vatAmount: json["vatAmount"],
        unitName: json["unitName"],
        propertyName: json["propertyName"],
        unitNameAr: json["unitNameAR"],
        unitPicture: json["unitPicture"],
        unitType: json["unitType"],
        unitTypeAr: json["unitTypeAR"],
        contractStatus: json["contractStatus"],
        contractStatusAr: json["contractStatusAr"],
        contractTypeId: json["contractTypeID"],
        unitNo: json["unitNo"],
        payment: Payment.fromJson(json["payment"]),
        noOfDaysLeft: daysLeft,
        noOfDaysPassed: daysPassed,
        complete: complete,
        amountFormatted: NumberFormat.currency(
                symbol: AppMetaLabels().aed, decimalDigits: 2, locale: 'AR')
            .format(json["rentforstay"]));
  }

  Map<String, dynamic> toJson() => {
        "contractPosition": contractPosition,
        "contractPositionName": contractPositionName,
        "propertyTypeID": propertyTypeId,
        "propertyStatusID": propertyStatusId,
        "isExpire": isExpire,
        "isreadyToExpire": isreadyToExpire,
        "contractID": contractId,
        "contractno": contractno,
        "address": address,
        "addressAR": addressAr,
        "contractDate": contractDate,
        "contractStartDate": contractStartDate,
        "contractEndDate": contractEndDate,
        "rentforstay": rentforstay,
        "noOfDays": noOfDays,
        "gracePeriod": gracePeriod,
        "noOfContractYears": noOfContractYears,
        "installments": installments,
        "retention": retention,
        "otherCharges": otherCharges,
        "vatCharges": vatCharges,
        "vatAmount": vatAmount,
        "unitName": unitName,
        "propertyName": propertyName,
        "unitNameAR": unitNameAr,
        "unitPicture": unitPicture,
        "unitType": unitType,
        "unitTypeAR": unitTypeAr,
        "contractStatus": contractStatus,
        "contractTypeID": contractTypeId,
        "contractStatusAr": contractStatusAr,
        "unitNo": unitNo,
        "payment": payment.toJson(),
      };
}

class Payment {
  Payment({
    this.total,
    this.paid,
  });

  dynamic total;
  dynamic paid;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        total: json["total"],
        paid: json["paid"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "paid": paid,
      };
}
