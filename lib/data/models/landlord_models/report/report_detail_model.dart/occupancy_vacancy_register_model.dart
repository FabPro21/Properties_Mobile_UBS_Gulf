import 'dart:convert';

OccupancyVacancyRegisterSummaryModel getOcupanyReportSUmmaryModelFromJson(
        String? str) =>
    OccupancyVacancyRegisterSummaryModel.fromJson(json.decode(str!));

class OccupancyVacancyRegisterSummaryModel {
  String? status;
  int? totalRecord;
  List<ServiceRequests>? serviceRequests;
  String? message;

  OccupancyVacancyRegisterSummaryModel(
      {this.status, this.totalRecord, this.serviceRequests, this.message});

  OccupancyVacancyRegisterSummaryModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    totalRecord = json['totalRecord'];
    if (json['serviceRequests'] != null) {
      serviceRequests = <ServiceRequests>[];
      json['serviceRequests'].forEach((v) {
        serviceRequests!.add(new ServiceRequests.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['status'] = this.status;
    data['totalRecord'] = this.totalRecord;
    if (this.serviceRequests != null) {
      data['serviceRequests'] =
          this.serviceRequests!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ServiceRequests {
  String? landlord;
  String? landlordAR;
  dynamic ubsNo;
  dynamic propertyName;
  dynamic propertyNameAR;
  dynamic emirateName;
  dynamic emirateNameAR;
  int? totalUnits;
  int? occupiedUnits;
  int? vacantUnits;
  dynamic noOfOccupancy;
  dynamic noOfVacancy;

  ServiceRequests(
      {this.landlord,
      this.landlordAR,
      this.ubsNo,
      this.propertyName,
      this.propertyNameAR,
      this.emirateName,
      this.emirateNameAR,
      this.totalUnits,
      this.occupiedUnits,
      this.vacantUnits,
      this.noOfOccupancy,
      this.noOfVacancy});

  ServiceRequests.fromJson(Map<String?, dynamic> json) {
    landlord = json['landlord'];
    landlordAR = json['landlordAR'];
    ubsNo = json['ubsNo'];
    propertyName = json['propertyName'];
    propertyNameAR = json['propertyNameAR'];
    emirateName = json['emirateName'];
    emirateNameAR = json['emirateNameAR'];
    totalUnits = json['totalUnits'];
    occupiedUnits = json['occupiedUnits'];
    vacantUnits = json['vacantUnits'];
    noOfOccupancy = json['noOfOccupancy'];
    noOfVacancy = json['noOfVacancy'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['landlord'] = this.landlord;
    data['landlordAR'] = this.landlordAR;
    data['ubsNo'] = this.ubsNo;
    data['propertyName'] = this.propertyName;
    data['propertyNameAR'] = this.propertyNameAR;
    data['emirateName'] = this.emirateName;
    data['emirateNameAR'] = this.emirateNameAR;
    data['totalUnits'] = this.totalUnits;
    data['occupiedUnits'] = this.occupiedUnits;
    data['vacantUnits'] = this.vacantUnits;
    data['noOfOccupancy'] = this.noOfOccupancy;
    data['noOfVacancy'] = this.noOfVacancy;
    return data;
  }
}
