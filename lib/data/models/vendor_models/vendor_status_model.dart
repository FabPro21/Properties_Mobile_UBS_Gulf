
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
        contractStatus!.add(new ContractStatus.fromJson(v));
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
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['serviceContractStatusID'] = this.serviceContractStatusID;
    data['statusName'] = this.statusName;
    data['statusNameAr'] = this.statusNameAr;
    return data;
  }
}
