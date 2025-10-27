
class GetContractStatusModelVendor {
  String? status;
  String? statusCode;
  List<ContractStatus>? contractStatus;
  String? message;

  GetContractStatusModelVendor(
      {this.status, this.statusCode, this.contractStatus, this.message});

  GetContractStatusModelVendor.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['contractStatus'] != null) {
      contractStatus = <ContractStatus>[];
      json['contractStatus'].forEach((v) {
        contractStatus!.add(ContractStatus.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class ContractStatus {
  int? serviceContractStatusID;
  String? statusName;
  String? statusNameAr;

  ContractStatus(
      {this.serviceContractStatusID, this.statusName, this.statusNameAr});

  ContractStatus.fromJson(Map<String?, dynamic> json) {
    serviceContractStatusID = json['serviceContractStatusID'];
    statusName = json['statusName'];
    statusNameAr = json['statusNameAr'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['serviceContractStatusID'] = serviceContractStatusID;
    data['statusName'] = statusName;
    data['statusNameAr'] = statusNameAr;
    return data;
  }
}
