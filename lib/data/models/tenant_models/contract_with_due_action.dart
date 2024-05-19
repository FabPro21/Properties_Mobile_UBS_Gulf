import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContractWithDueAction {
  ContractWithDueAction(
      {this.dueActionid,
      this.contractid,
      this.caseId,
      this.expiringingDays,
      this.renewalContractid,
      this.stageId,
      this.stageName,
      this.previousContractNo,
      this.propertyName,
      this.propertyNameAr,
      this.fromdate,
      this.toDate,
      this.contractno,
      this.isCanceled,
      this.isClosed,
      this.status,
      this.statusAr,
      this.showExtend,
      this.isAllPaid,
      this.emirateName,
      this.showOfferLetter});

  int dueActionid;
  int contractid;
  int caseId;
  int expiringingDays;
  int renewalContractid;
  int stageId;
  String stageName;
  String previousContractNo;
  String propertyName;
  String propertyNameAr;
  String fromdate;
  String toDate;
  String contractno;
  int isCanceled;
  int isClosed;
  String status;
  String statusAr;
  bool showExtend;
  int isAllPaid;
  String emirateName;
  int showOfferLetter;

  RxBool downloading = false.obs;

  factory ContractWithDueAction.fromJson(Map<String, dynamic> json) {
    bool showExtend = true;
    try {
      DateTime endDate = DateFormat('dd-MM-yyyy').parse(json["toDate"]);
      if (DateTime.now().difference(endDate).inDays >= 15) {
        showExtend = false;
      }
    } catch (_) {}
    return ContractWithDueAction(
        dueActionid: json["dueActionid"],
        contractid: json["contractid"],
        caseId: json["caseId"],
        expiringingDays: json["expiringingDays"],
        renewalContractid: json["renewalContractid"],
        stageId: json["stageId"],
        stageName: json["stageName"],
        previousContractNo: json["previousContractNo"],
        propertyName: json["propertyName"],
        propertyNameAr: json["propertyNameAr"],
        fromdate: json["fromdate"],
        toDate: json["toDate"],
        contractno: json["contractno"],
        isCanceled: json["isCanceled"],
        isClosed: json["isClosed"],
        status: json["status"],
        statusAr: json["statusAr"],
        showExtend: showExtend,
        isAllPaid: json["isAllPaid"],
        emirateName: json["emirateName"],
        showOfferLetter: json["showOfferLetter"]);
  }

  Map<String, dynamic> toJson() => {
        "dueActionid": dueActionid,
        "contractid": contractid,
        "caseId": caseId,
        "expiringingDays": expiringingDays,
        "renewalContractid": renewalContractid,
        "stageId": stageId,
        "stageName": stageName,
        "propertyName": propertyName,
        "fromdate": fromdate,
        "toDate": toDate,
        "contractno": contractno,
        "isCanceled": isCanceled,
        "isClosed": isClosed,
        "status": status,
      };
}
