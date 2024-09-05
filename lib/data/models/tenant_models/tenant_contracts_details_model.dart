// To parse this JSON data, do
//
//     final getContractDetailsModel = getContractDetailsModelFromJson(jsonString);

import 'dart:convert';

GetContractDetailsModel getContractDetailsModelFromJson(String? str) =>
    GetContractDetailsModel.fromJson(json.decode(str!));

String? getContractDetailsModelToJson(GetContractDetailsModel data) =>
    json.encode(data.toJson());

class GetContractDetailsModel {
  GetContractDetailsModel(
      {this.status,
      this.contract,
      this.message,
      this.caseNo,
      this.signed,
      this.canPayment,
      this.canSignature,
      this.caseType,
      this.checkInCaseNo,
      this.legalCaseNo,
      this.paymentDone,
      this.canDownload,
      this.canCheckin,
      this.caseStageInfo});

  String? status;
  Contract? contract;
  String? message;
  int? caseNo;
  int? signed;
  int? canPayment;
  int? canSignature;
  String? caseType;
  int? checkInCaseNo;
  int? legalCaseNo;
  int? paymentDone;
  int? canDownload;
  dynamic canCheckin;
  CaseStageInfo? caseStageInfo;

  factory GetContractDetailsModel.fromJson(Map<String?, dynamic> json) =>
      GetContractDetailsModel(
          status: json["status"],
          contract: Contract.fromJson(json["contract"]),
          message: json["message"],
          caseNo: json["caseExist"],
          signed: json["signed"],
          canPayment: json["canPayment"],
          canSignature: json["canSignature"],
          caseType: json["caseType"],
          checkInCaseNo: json["checkInCaseNo"],
          legalCaseNo: json["legalCaseNo"],
          paymentDone: json["paymentDone"],
          canDownload: json["canDownload"],
          canCheckin: json["canCheckin"],
          caseStageInfo: CaseStageInfo.fromJson(json["caseStageInfo"]));

  Map<String?, dynamic> toJson() => {
        "status": status,
        "contract": contract!.toJson(),
        "message": message,
      };
}

class Contract {
  Contract(
      {this.propertyTypeId,
      this.propertyStatusId,
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
      this.unitNameAr,
      this.unitPicture,
      this.unitType,
      this.unitTypeAr,
      this.contractStatus,
      this.contractStatusAR,
      this.unitNo,
      this.payment,
      this.isExpire,
      this.isreadyToExpire,
      this.contractPosition,
      this.isCanceled});

  dynamic propertyTypeId;
  dynamic propertyStatusId;
  dynamic contractId;
  String? contractno;
  String? address;
  String? addressAr;
  String? contractDate;
  String? contractStartDate;
  String? contractEndDate;
  dynamic rentforstay;
  dynamic noOfDays;
  dynamic gracePeriod;
  dynamic noOfContractYears;
  dynamic installments;
  String? retention;
  dynamic otherCharges;
  dynamic vatCharges;
  dynamic vatAmount;
  String? unitName;
  String? unitNameAr;
  String? unitPicture;
  String? unitType;
  dynamic unitTypeAr;
  String? contractStatus;
  String? contractStatusAR;
  String? unitNo;
  Payment? payment;
  int? isExpire;
  int? isreadyToExpire;
  int? contractPosition;
  int? isCanceled;

  factory Contract.fromJson(Map<String?, dynamic> json) {
    String? status = json["contractStatus"];
    String? statusAr = json["contractStatusAR"];
    if (status == 'Posted') status = 'Active';
    return Contract(
        propertyTypeId: json["propertyTypeID"],
        propertyStatusId: json["propertyStatusID"],
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
        unitNameAr: json["unitNameAR"],
        unitPicture: json["unitPicture"],
        unitType: json["unitType"],
        unitTypeAr: json["unitTypeAR"],
        contractStatus: status,
        contractStatusAR: statusAr,
        unitNo: json["unitNo"],
        payment: Payment.fromJson(json["payment"]),
        isExpire: json["isExpire"],
        isreadyToExpire: json["isreadyToExpire"],
        contractPosition: json["contractPosition"],
        isCanceled: json["isCanceled"]
        );
  }

  Map<String?, dynamic> toJson() => {
        "propertyTypeID": propertyTypeId,
        "propertyStatusID": propertyStatusId,
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
        "unitNameAR": unitNameAr,
        "unitPicture": unitPicture,
        "unitType": unitType,
        "unitTypeAR": unitTypeAr,
        "contractStatus": contractStatus,
        "unitNo": unitNo,
        "payment": payment!.toJson(),
      };
}

class Payment {
  Payment({
    this.total,
    this.paid,
  });

  dynamic total;
  dynamic paid;

  factory Payment.fromJson(Map<String?, dynamic> json) => Payment(
        total: json["total"],
        paid: json["paid"],
      );

  Map<String?, dynamic> toJson() => {
        "total": total,
        "paid": paid,
      };
}

class CaseStageInfo {
  CaseStageInfo({
    this.caseid,
    this.stageId,
    this.dueActionid,
  });

  int? caseid;
  int? stageId;
  int? dueActionid;

  factory CaseStageInfo.fromJson(Map<String?, dynamic> json) => CaseStageInfo(
        caseid: json["caseid"],
        stageId: json["stageId"],
        dueActionid: json["dueActionid"],
      );

  Map<String?, dynamic> toJson() => {
        "caseid": caseid,
        "stageId": stageId,
        "dueActionid": dueActionid,
      };
}
