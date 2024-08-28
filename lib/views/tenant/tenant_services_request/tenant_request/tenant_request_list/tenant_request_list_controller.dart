// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/get_tenant_service_requests_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:flutter/material.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class GetTenantServiceRequestsController extends GetxController {
  /////////////// Maintenance/FM Service Requests
  List<ServiceRequest> allSvcReqFM = [];
  List<ServiceRequest> serviceRequestsFM = [];

  var loadingDataFM = true.obs;
  RxString onSearch = "".obs;
  RxString errorFM = "".obs;

  DateTime? fromDate;
  DateTime? toDate;

  void getData() {
    getDataPM('');
    getDataFM('');
    //old
    // getDataPM();
    // getDataFM();
  }

  var fromDateN = "".obs;
  var toDateN = "".obs;
  var fromDateNText = "".obs;
  var toDateNText = "".obs;
  var filterError = "".obs;
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  bool setFromDate(DateTime date) {
    print('From date ::1:: $date');
    if (toDateN.value == "" || toDateN.value == null) {
      print('From date ::2:: $date');
      fromDateN.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      fromDateNText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      fromController.text = fromDateNText.value;
      print('From Date ::3:: ');
      print(fromController.text);
      return true;
    }
    print('From date ::4:: $date');
    var splittedToDate = toDateN.value.split('-');
    String date2 = splittedToDate[2] + splittedToDate[0] + splittedToDate[1];
    if (date.isBefore(DateTime.parse(date2))) {
      fromDateN.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      fromDateNText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      fromController.text = fromDateNText.value;
      print('From Date ::5:: ');
      print(toController.text);
      return true;
    } else {
      print('From Date ::6:: ');
      fromController.text = '';
      return false;
    }
  }

  String formatDate(int num) {
    return (num < 10 ? "0" : "") + num.toString();
  }

  bool setToDate(DateTime date) {
    if (fromDateN.value == '') {
      toDateN.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      toDateNText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      toController.text = toDateNText.value;
      print('To Date :::: ');
      print(toController.text);
      return true;
    }
    var splittedFromDate = fromDateN.value.split('-');
    String date2 =
        splittedFromDate[2] + splittedFromDate[0] + splittedFromDate[1];
    if (date.isAfter(DateTime.parse(date2))) {
      toDateN.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      toDateNText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      toController.text = toDateNText.value;
      print('To Date :::: ');
      print(toController.text);
      return true;
    } else {
      toController.text = '';
      return false;
    }
  }

  searchSvcReqFM(String q) {
    q.toLowerCase();
    print('Insode the FM func');
    loadingDataFM.value = true;
    errorFM.value = '';
    try {
      serviceRequestsFM.clear();
      for (int i = 0; i < allSvcReqFM.length; i++) {
        if ((allSvcReqFM[i].requestNo.toString().contains(q) ||
                allSvcReqFM[i].category!.toLowerCase().contains(q) ||
                allSvcReqFM[i].categoryAR!.toLowerCase().contains(q) ||
                allSvcReqFM[i].subCategory!.toLowerCase().contains(q) ||
                allSvcReqFM[i].subCategoryAR!.toLowerCase().contains(q) ||
                allSvcReqFM[i].propertyName!.toLowerCase().contains(q) ||
                allSvcReqFM[i].propertyNameAr!.toLowerCase().contains(q) ||
                allSvcReqFM[i].status!.toLowerCase().contains(q) ||
                allSvcReqFM[i]
                    .statusAR!
                    .toLowerCase()
                    .contains(q)) || // replace || instead of &&
            // allSvcReqFM[i].statusAR.toLowerCase().contains(q)) &&
            DateFormat('dd-MM-yyyy')
                    .parse(allSvcReqFM[i].date??"")
                    .isAfter(fromDate!) &&
                DateFormat('dd-MM-yyyy')
                    .parse(allSvcReqFM[i].date??"")
                    .isBefore(toDate!)) {
          print('Inside If of the FM func');
          serviceRequestsFM.add(allSvcReqFM[i]);
          update();
        }
      }
      print('Inside FM func Length : ${serviceRequestsFM.length}');
      if (serviceRequestsFM.length == 0) {
        errorFM.value = AppMetaLabels().notFound;
      } else {
        errorFM.value = '';
      }
      if (q.isEmpty) {
        serviceRequestsFM = allSvcReqFM.toList();
      }
    } catch (e) {
      if (kDebugMode) print(e);
      errorFM.value = AppMetaLabels().notFound;
    }
    loadingDataFM.value = false;
  }

  /////////////// Leasing/PM Service Requests
  List<ServiceRequest> allSvcReqPM = [];
  List<ServiceRequest> serviceRequestsPM = [];

  var loadingDataPM = true.obs;
  RxString errorPM = "".obs;

  Future<void> getDataPM(String search) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      loadingDataPM.value = true;
      errorPM.value = '';
      var result = await TenantRepository.getTenantServiceRequests(
          'PM',
          fromDateN.value == null || fromDateN.value == ''
              ? ''
              : fromDateN.value,
          toDateN.value == null || toDateN.value == '' ? '' : toDateN.value,
          search);
      print(result);
      loadingDataPM.value = false;
      if (result is GetTenantServiceRequestsModel) {
        allSvcReqPM = result.serviceRequests!;
        serviceRequestsPM = allSvcReqPM.toList();
        if (serviceRequestsPM.isEmpty) errorPM.value = AppMetaLabels().notFound;
      } else {
        errorPM.value = result;
      }
    } catch (e) {
      print('Exception :::::getDataPM:::: ${e.toString()}');
    }
  }

  Future<void> getDataFM(String search) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      loadingDataFM.value = true;
      var result = await TenantRepository.getTenantServiceRequests(
          'FM',
          fromDateN.value == null || fromDateN.value == ''
              ? ''
              : fromDateN.value,
          toDateN.value == null || toDateN.value == '' ? '' : toDateN.value,
          // fDate,
          // tDate,
          // fromDate == null ? '' : fromDate.toString(),
          // toDate == null ? '' : toDate.toString(),
          search);
      print(result);

      errorFM.value = '';
      print(result);
      loadingDataFM.value = false;
      if (result is GetTenantServiceRequestsModel) {
        allSvcReqFM = result.serviceRequests!;
        serviceRequestsFM = allSvcReqFM.toList();
        if (serviceRequestsFM.isEmpty) errorFM.value = AppMetaLabels().notFound;
      } else {
        errorFM.value = result;
      }
    } catch (e) {
      print('Exception :::::getDataPM:::: ${e.toString()}');
    }
  }

  /// old
  // Future<void> getDataPM() async {
  //   bool _isInternetConnected = await BaseClientClass.isInternetConnected();
  //   if (!_isInternetConnected) {
  //     await Get.to(() => NoInternetScreen());
  //   }
  //   // try {
  //   loadingDataPM.value = true;
  //   errorPM.value = '';
  //   var result = await TenantRepository.getTenantServiceRequests('PM');
  //   print(result);
  //   loadingDataPM.value = false;
  //   if (result is GetTenantServiceRequestsModel) {
  //     allSvcReqPM = result.serviceRequests;
  //     serviceRequestsPM = allSvcReqPM.toList();
  //     if (serviceRequestsPM.isEmpty) errorPM.value = AppMetaLabels().notFound;
  //   } else {
  //     errorPM.value = result;
  //   }
  // }
  ////
  // Future<void> getDataFM() async {
  //   bool _isInternetConnected = await BaseClientClass.isInternetConnected();
  //   if (!_isInternetConnected) {
  //     await Get.to(() => NoInternetScreen());
  //   }
  //   // try {
  //   loadingDataFM.value = true;
  //   errorFM.value = '';
  //   var result = await TenantRepository.getTenantServiceRequests('FM');
  //   print(result);
  //   loadingDataFM.value = false;
  //   if (result is GetTenantServiceRequestsModel) {
  //     allSvcReqFM = result.serviceRequests;
  //     serviceRequestsFM = allSvcReqFM.toList();
  //     if (serviceRequestsFM.isEmpty) errorFM.value = AppMetaLabels().notFound;
  //   } else {
  //     errorFM.value = result;
  //   }
  // }

  searchSvcReqPM(String q) {
    q.toLowerCase();
    loadingDataPM.value = true;
    try {
      serviceRequestsPM.clear();
      for (int i = 0; i < allSvcReqPM.length; i++) {
        if ((allSvcReqPM[i].requestNo.toString().contains(q) ||
                allSvcReqPM[i].category!.toLowerCase().contains(q) ||
                allSvcReqPM[i].categoryAR!.toLowerCase().contains(q) ||
                allSvcReqPM[i].subCategory!.toLowerCase().contains(q) ||
                allSvcReqPM[i].subCategoryAR!.toLowerCase().contains(q) ||
                allSvcReqPM[i].propertyName!.toLowerCase().contains(q) ||
                allSvcReqPM[i].propertyNameAr!.toLowerCase().contains(q) ||
                allSvcReqPM[i].status!.toLowerCase().contains(q) ||
                allSvcReqPM[i].statusAR!.toLowerCase().contains(q)) ||
            DateFormat('dd-MM-yyyy')
                    .parse(allSvcReqPM[i].date??"")
                    .isAfter(fromDate!) &&
                DateFormat('dd-MM-yyyy')
                    .parse(allSvcReqPM[i].date??"")
                    .isBefore(toDate!)) {
          // if ((allSvcReqPM[i].requestNo.toString().contains(q) ||
          //         allSvcReqPM[i].category.toLowerCase().contains(q) ||
          //         allSvcReqPM[i].categoryAR.toLowerCase().contains(q) ||
          //         allSvcReqPM[i].subCategory.toLowerCase().contains(q) ||
          //         allSvcReqPM[i].subCategoryAR.toLowerCase().contains(q) ||
          //         allSvcReqPM[i].propertyName.toLowerCase().contains(q) ||
          //         allSvcReqPM[i].propertyNameAr.toLowerCase().contains(q) ||
          //         allSvcReqPM[i].status.toLowerCase().contains(q) ||
          //         allSvcReqPM[i].statusAR.toLowerCase().contains(q)) &&
          //     DateFormat('dd-MM-yyyy')
          //         .parse(allSvcReqPM[i].date)
          //         .isAfter(fromDate) &&
          //     DateFormat('dd-MM-yyyy')
          //         .parse(allSvcReqPM[i].date)
          //         .isBefore(toDate)) {
          serviceRequestsPM.add(allSvcReqPM[i]);
        }
      }
      if (serviceRequestsPM.length == 0) {
        errorPM.value = AppMetaLabels().notFound;
      } else {
        errorPM.value = '';
      }
      if (q.isEmpty) {
        serviceRequestsPM = allSvcReqPM.toList();
      }
    } catch (e) {
      if (kDebugMode) print(e);
      errorPM.value = AppMetaLabels().notFound;
    }
    loadingDataPM.value = false;
  }

  void applyFilter() {}

  void clearFilter() {}
}
