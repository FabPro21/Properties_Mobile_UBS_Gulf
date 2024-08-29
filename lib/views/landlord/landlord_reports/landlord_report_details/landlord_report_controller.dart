// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/download_report_model.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_emirate_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_download_report.dart';
import 'package:fap_properties/data/models/landlord_models/property_filter.dart';
import 'package:fap_properties/data/models/landlord_models/report/get_dropdown_model.dart'
    as dropDownModel;
import 'package:fap_properties/data/models/landlord_models/report/report_detail_model.dart/amc_summary_model.dart';
import 'package:fap_properties/data/models/landlord_models/report/report_detail_model.dart/building_status_summary_model.dart';
import 'package:fap_properties/data/models/landlord_models/report/report_detail_model.dart/chequ_register_summary_model.dart';
import 'package:fap_properties/data/models/landlord_models/report/report_detail_model.dart/contract_summary_model.dart';
import 'package:fap_properties/data/models/landlord_models/report/report_detail_model.dart/legal_case_report_summary_model.dart';
import 'package:fap_properties/data/models/landlord_models/report/report_detail_model.dart/lpo_report_model.dart';
import 'package:fap_properties/data/models/landlord_models/report/report_detail_model.dart/occupancy_vacancy_register_model.dart';
import 'package:fap_properties/data/models/landlord_models/report/report_detail_model.dart/receipt_register_report_model.dart';
import 'package:fap_properties/data/models/landlord_models/report/report_detail_model.dart/unit_status_report_model.dart';
import 'package:fap_properties/data/models/landlord_models/report/report_detail_model.dart/vat_report_model.dart';

import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class LandLordReportPropController extends GetxController {
  TextEditingController unitRefNoController = TextEditingController();
  TextEditingController contractNoController = TextEditingController();
  // Rx<ServiceRequests> propType = ServiceRequests().obs;
  var selectedPropType = dropDownModel.ServiceRequests().obs;
  var selectedChequeStatus = dropDownModel.ServiceRequests().obs;
  var selectedUnitStatus = dropDownModel.ServiceRequests().obs;
  // Rx<dropDownModel.ServiceRequests> propType =
  //     dropDownModel.ServiceRequests().obs;

  var selectedcontractorType = dropDownModel.ServiceRequests().obs;
  // Rx<dropDownModel.ServiceRequests> contractorType =
  //     dropDownModel.ServiceRequests().obs;

  var selectedcontractCategoryType = dropDownModel.ServiceRequests().obs;
  // Rx<dropDownModel.ServiceRequests> contractCategoryType =
  //     dropDownModel.ServiceRequests().obs;

  var selectedserviceContractStatusType = dropDownModel.ServiceRequests().obs;

  var selectedTransactionID = dropDownModel.ServiceRequests().obs;
  // Rx<dropDownModel.ServiceRequests> serviceContractStatusType =
  //     dropDownModel.ServiceRequests().obs;

  // Rx<PropertyType> propType = PropertyType().obs;
  Rx<PropertyEmirate> emirateName = PropertyEmirate().obs;
  var filterError = "".obs;
  var asnoDate = "".obs;
  var fromDate = "".obs;
  var toDate = "".obs;
  var fromDateText = "".obs;
  var asnoDateText = "".obs;
  var toDateText = "".obs;
  ReportFilterData? filterData;

  RxBool isLoading = false.obs;
  RxString isFileDownloadError = ''.obs;

  void resetValues() {
    // propType.value = ServiceRequests();
    selectedPropType.value = dropDownModel.ServiceRequests();
    selectedcontractorType.value = dropDownModel.ServiceRequests();
    selectedcontractCategoryType.value = dropDownModel.ServiceRequests();
    selectedserviceContractStatusType.value = dropDownModel.ServiceRequests();
    // propType.value = dropDownModel.ServiceRequests();
    // contractorType.value = dropDownModel.ServiceRequests();
    // contractCategoryType.value = dropDownModel.ServiceRequests();
    // serviceContractStatusType.value = dropDownModel.ServiceRequests();
    emirateName.value = PropertyEmirate();
    fromDate.value = '';
    toDate.value = '';
    fromDateText.value = '';
    asnoDateText.value = '';
    toDateText.value = '';
  }

  @override
  void onInit() {
    super.onInit();
  }

  DateTime? fromDateDT;
  DateTime? toDateDT;
  DateTime? asNoDateDT;

  bool setAsnoDate(DateTime date) {
    if (date != null) {
      asnoDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      asnoDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      return true;
    } else {
      return false;
    }
  }

  bool setFromDate(DateTime date) {
    if (toDate.value == '') {
      fromDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      fromDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      return true;
    }
    var splittedToDate = toDate.value.split('-');
    String date2 = splittedToDate[2] + splittedToDate[0] + splittedToDate[1];
    if (date.isBefore(DateTime.parse(date2))) {
      fromDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      fromDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      return true;
    } else {
      return false;
    }
  }

  bool setToDate(DateTime date) {
    if (fromDate.value == '') {
      toDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      toDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      return true;
    }
    var splittedFromDate = fromDate.value.split('-');
    String date2 =
        splittedFromDate[2] + splittedFromDate[0] + splittedFromDate[1];
    if (date.isAfter(DateTime.parse(date2))) {
      toDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      toDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      return true;
    } else {
      return false;
    }
  }

  String formatDate(int num) {
    return (num < 10 ? "0" : "") + num.toString();
  }

  Future<String> downLoadReportFile(String fileName, Map data) async {
    isFileDownloadError.value = '';
    isLoading.value = true;
    final response =
        await LandlordRepository.downloadReportFile(fileName, data);
    print('Response:::::: $response');
    isLoading.value = false;
    if (response is DownloadReportModel) {
      isFileDownloadError.value = '';
      return response.filePath!.result!;
    } else {
      isFileDownloadError.value = response;
      return ' ';
    }
  }

  LandlordDownloadReportModel? downloadedFileModel;
  Future<bool> downLoadReportFilebase64(String fileName, Map data) async {
    isLoading.value = true;
    isFileDownloadError.value = '';
    var response =
        await LandlordRepository.downloadTicketFileBase64(fileName, data);
    isLoading.value = false;
    if (response is LandlordDownloadReportModel) {
      downloadedFileModel = response;
      // if (response is Uint8List) {
      if (await getTemporaryDirectory() != null) {
        var base64 = response.base64;
        if (base64!.isNotEmpty ||
            base64 != '' ||
            base64 != null && response.message != 'No Records Found') {
          try {
            var base64Decoded = base64Decode(base64.replaceAll('\n', ''));
            var dt = DateTime.now();
            List months = [
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec'
            ];
            var fileName = response.name! +
                ' ' +
                '${dt.day} ${months[dt.month - 1]} ${dt.hour}-${dt.minute}-${dt.second}' +
                '.' +
                response.extension!;
            // var fileName = response.name + '.' + response.extension;
            var res = await saveFileInsideTheDevice(base64Decoded, fileName);

            return res;
          } catch (e) {
            isLoading.value = false;
            print(e.toString());
            Get.snackbar(
              AppMetaLabels().error,
              e.toString(),
              backgroundColor: AppColors.white54,
            );
            return false;
          }
        } else {
          SnakBarWidget.getSnackBarErrorBlueWith5Sec(
              AppMetaLabels().alert, AppMetaLabels().noDatafound);
          return false;
        }
      }
      isLoading.value = false;
      return false;
    } else {
      isLoading.value = false;
      Get.snackbar(
        AppMetaLabels().error,
        response,
        backgroundColor: AppColors.white54,
      );
      return false;
    }
  }

  Future<bool> saveFileInsideTheDevice(Uint8List bytes, String fileName) async {
    try {
      // Get the directory where the file will be saved
      final status = await Permission.storage.status;
      Directory _directory = Directory("");
      if (status.isGranted) {
        if (Platform.isAndroid) {
          // Redirects it to download folder in android
          _directory = Directory("/storage/emulated/0/Download");
        } else {
          _directory = await getApplicationDocumentsDirectory();
        }
        final exPath = _directory.path;
        print("Saved Path: $exPath");
        print("File Name: $fileName");
        await Directory(exPath).create(recursive: false);

        final path = exPath;

        File file = File('$path/$fileName');

        // Write the data in the file you have created
        var res = await file.writeAsBytes(bytes.buffer.asUint8List());
        print('Res::::::::$res');

        print(await File('$path/$fileName').exists());
        await SnakBarWidget.getSnackBarErrorBlueWith5Sec(
            AppMetaLabels().success,
            AppMetaLabels().fileDownloadedSuccessfully);

        return true;
      } else {
        await Permission.storage.request();
      }
      return true;
    } catch (e) {
      print('Exception :::: Inside the ::::: save func ${e.toString()}');
      Get.snackbar(
        AppMetaLabels().error,
        e.toString(),
        backgroundColor: AppColors.white54,
      );
      return false;
    }
  }

  // create file for open
  Future<String> createFile(Uint8List data, String fileName) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$fileName");
    await file.writeAsBytes(data.buffer.asUint8List());
    return "${output.path}/$fileName";
  }

  // Summary
  RxBool isLoadingSummary = false.obs;
  RxString errorSummaryReport = ''.obs;
  // // generate AMC Summary
  var amcRepportModel = AMCReportSummaryModel().obs; // 1
  var buildingStatusReportModel = BuildingStatusSummaryModel().obs; // 2
  var chequeRegisterReportModel = ChequeRegisterReportSummaryModel().obs; // 3
  var contractReportModel = ContractSummaryModel().obs; // 4
  var legalCaseReportModel = LegalCaseReportSummaryModel().obs; // 5
  var occupanyReportModel = OccupancyVacancyRegisterSummaryModel().obs; //  6
  var receiptRegisterModel = ReceipRegisterReportSummaryModel().obs; //  7
  var unitStatusReportModel = UnitStatusReportSummaryModel().obs; //  8
  var vatReportSummaryModel = VATReportSummaryModel().obs; //  9
  var lpoReportSummaryModel = LpoReportSummaryModel().obs; //  10
  getreportSummary(Map data, String reportName) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      errorSummaryReport.value = '';
      isLoadingSummary.value = true;
      var result = await LandlordRepository.getreportSummary(data, reportName);
      print('Condition:::::');
      // 1
      if (result is AMCReportSummaryModel) {
        amcRepportModel.value = result;
        print(
            'Result Controller:::$reportName::: ${amcRepportModel.value.serviceRequests!.length}');
        if (amcRepportModel.value.totalRecord == 0) {
          errorSummaryReport.value = AppMetaLabels().noDatafound;
          isLoadingSummary.value = false;
        } else {
          update();
          isLoadingSummary.value = false;
        }
      }
      // 2
      else if (result is BuildingStatusSummaryModel) {
        buildingStatusReportModel.value = result;
        print(
            'Result Controller:::$reportName::: ${buildingStatusReportModel.value.serviceRequests!.length}');
        if (buildingStatusReportModel.value.totalRecord == 0) {
          errorSummaryReport.value = AppMetaLabels().noDatafound;
          isLoadingSummary.value = false;
        } else {
          update();
          isLoadingSummary.value = false;
        }
      }
      // 3
      else if (result is ChequeRegisterReportSummaryModel) {
        chequeRegisterReportModel.value = result;
        print(
            'Result Controller:::$reportName::: ${chequeRegisterReportModel.value.serviceRequests!.length}');
        if (chequeRegisterReportModel.value.totalRecord == 0) {
          errorSummaryReport.value = AppMetaLabels().noDatafound;
          isLoadingSummary.value = false;
        } else {
          update();
          isLoadingSummary.value = false;
        }
      }
      // 4
      else if (result is ContractSummaryModel) {
        contractReportModel.value = result;
        print(
            'Result Controller:::$reportName::: ${contractReportModel.value.serviceRequests!.length}');
        if (contractReportModel.value.totalRecord == 0) {
          errorSummaryReport.value = AppMetaLabels().noDatafound;
          isLoadingSummary.value = false;
        } else {
          update();
          isLoadingSummary.value = false;
        }
      }
      // 5
      else if (result is LegalCaseReportSummaryModel) {
        legalCaseReportModel.value = result;
        print(
            'Result Controller:::$reportName::: ${legalCaseReportModel.value.serviceRequests!.length}');
        if (legalCaseReportModel.value.totalRecord == 0) {
          errorSummaryReport.value = AppMetaLabels().noDatafound;
          isLoadingSummary.value = false;
        } else {
          update();
          isLoadingSummary.value = false;
        }
      }
      // 6
      else if (result is OccupancyVacancyRegisterSummaryModel) {
        occupanyReportModel.value = result;
        print(
            'Result Controller:::$reportName::: ${occupanyReportModel.value.serviceRequests!.length}');
        if (occupanyReportModel.value.totalRecord == 0) {
          errorSummaryReport.value = AppMetaLabels().noDatafound;
          isLoadingSummary.value = false;
        } else {
          update();
          isLoadingSummary.value = false;
        }
      }
      // 7
      else if (result is ReceipRegisterReportSummaryModel) {
        receiptRegisterModel.value = result;
        print(
            'Result Controller:::$reportName::: ${receiptRegisterModel.value.serviceRequests!.length}');
        if (receiptRegisterModel.value.totalRecord == 0) {
          errorSummaryReport.value = AppMetaLabels().noDatafound;
          isLoadingSummary.value = false;
        } else {
          update();
          isLoadingSummary.value = false;
        }
      }
      // 8
      else if (result is UnitStatusReportSummaryModel) {
        unitStatusReportModel.value = result;
        print(
            'Result Controller:::$reportName::: ${unitStatusReportModel.value.serviceRequests!.length}');
        if (unitStatusReportModel.value.totalRecord == 0) {
          errorSummaryReport.value = AppMetaLabels().noDatafound;
          isLoadingSummary.value = false;
        } else {
          update();
          isLoadingSummary.value = false;
        }
      }
      // 9
      else if (result is VATReportSummaryModel) {
        vatReportSummaryModel.value = result;
        print(
            'Result Controller:::$reportName::: ${vatReportSummaryModel.value.serviceRequests!.length}');
        if (vatReportSummaryModel.value.totalRecord == 0) {
          errorSummaryReport.value = AppMetaLabels().noDatafound;
          isLoadingSummary.value = false;
        } else {
          update();
          isLoadingSummary.value = false;
        }
      }
      // 10
      else if (result is LpoReportSummaryModel) {
        lpoReportSummaryModel.value = result;
        print(
            'Result Controller:::$reportName::: ${lpoReportSummaryModel.value.serviceRequests!.length}');
        if (lpoReportSummaryModel.value.totalRecord == 0) {
          errorSummaryReport.value = AppMetaLabels().noDatafound;
          isLoadingSummary.value = false;
        } else {
          update();
          isLoadingSummary.value = false;
        }
      } else {
        errorSummaryReport.value = AppMetaLabels().noDatafound;
        isLoadingSummary.value = false;
      }
    } catch (e) {
      isLoadingSummary.value = false;
      errorSummaryReport.value = AppMetaLabels().someThingWentWrong;
      print("this is the error from controller= $e");
    }
  }
}
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:fap_properties/data/models/landlord_models/download_report_model.dart';
// import 'package:fap_properties/data/models/landlord_models/filter_property_emirate_model.dart';
// import 'package:fap_properties/data/models/landlord_models/filter_property_type_model.dart';
// import 'package:fap_properties/data/models/landlord_models/landlord_download_report.dart';
// import 'package:fap_properties/data/models/landlord_models/property_filter.dart';
// import 'package:fap_properties/data/repository/landlord_repository.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/views/widgets/snackbar_widget.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class LandLordReportPropController extends GetxController {
//   Rx<PropertyType> propType = ServiceRequests().obs;
//   // Rx<PropertyType> propType = PropertyType().obs;
//   Rx<PropertyEmirate> emirateName = PropertyEmirate().obs;
//   var filterError = "".obs;
//   var fromDate = "".obs;
//   var toDate = "".obs;
//   ReportFilterData filterData;

//   RxBool isLoading = false.obs;
//   RxString isFileDownloadError = ''.obs;

//   void resetValues() {
//     propType.value = PropertyType();
//     emirateName.value = PropertyEmirate();
//     fromDate.value = '';
//     toDate.value = '';
//   }

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   bool setFromDate(DateTime date) {
//     if (toDate.value == '') {
//       fromDate.value =
//           "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
//       return true;
//     }
//     var splittedToDate = toDate.value.split('-');
//     String date2 = splittedToDate[2] + splittedToDate[0] + splittedToDate[1];
//     if (date.isBefore(DateTime.parse(date2))) {
//       fromDate.value =
//           "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
//       return true;
//     } else {
//       return false;
//     }
//   }

//   bool setToDate(DateTime date) {
//     if (fromDate.value == '') {
//       toDate.value =
//           "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
//       return true;
//     }
//     var splittedFromDate = fromDate.value.split('-');
//     String date2 =
//         splittedFromDate[2] + splittedFromDate[0] + splittedFromDate[1];
//     if (date.isAfter(DateTime.parse(date2))) {
//       toDate.value =
//           "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
//       return true;
//     } else {
//       return false;
//     }
//   }

//   String formatDate(int num) {
//     return (num < 10 ? "0" : "") + num.toString();
//   }

//   Future<String> downLoadReportFile(String fileName, Map data) async {
//     isFileDownloadError.value = '';
//     isLoading.value = true;
//     final response =
//         await LandlordRepository.downloadReportFile(fileName, data);
//     print('Response:::::: $response');
//     isLoading.value = false;
//     if (response is DownloadReportModel) {
//       isFileDownloadError.value = '';
//       return response.filePath.result;
//     } else {
//       isFileDownloadError.value = response;
//       return ' ';
//     }
//   }

//   LandlordDownloadReportModel downloadedFileModel;
//   Future<bool> downLoadReportFilebase64(String fileName, Map data) async {
//     isLoading.value = true;
//     isFileDownloadError.value = '';
//     var response =
//         await LandlordRepository.downloadTicketFileBase64(fileName, data);
//     isLoading.value = false;
//     if (response is LandlordDownloadReportModel) {
//       downloadedFileModel = response;
//       // if (response is Uint8List) {
//       if (await getTemporaryDirectory() != null) {
//         var base64 = response.base64;
//         if (base64.isNotEmpty || base64 != '' || base64 != null) {
//           try {
//             var base64Decoded = base64Decode(base64.replaceAll('\n', ''));
//             var res = await saveFileInsideTheDevice(base64Decoded,
//                 response.name +'.'+ response.extension);

//             return res;
//           } catch (e) {
//             isLoading.value = false;
//             Get.snackbar(
//               AppMetaLabels().error,
//               e.message.toString(),
//               backgroundColor: AppColors.white54,
//             );
//             return false;
//           }
//         }
//       }
//       isLoading.value = false;
//       return false;
//     } else {
//       isLoading.value = false;
//       Get.snackbar(
//         AppMetaLabels().error,
//         response,
//         backgroundColor: AppColors.white54,
//       );
//       return false;
//     }
//   }

//   Future<bool> saveFileInsideTheDevice(Uint8List bytes, String fileName) async {
//     try {
//       // Get the directory where the file will be saved
//       final status = await Permission.storage.status;
//       Directory _directory = Directory("");
//       if (status.isGranted) {
//         if (Platform.isAndroid) {
//           // Redirects it to download folder in android
//           _directory = Directory("/storage/emulated/0/Download");
//         } else {
//           _directory = await getApplicationDocumentsDirectory();
//         }
//         final exPath = _directory.path;
//         print("Saved Path: $exPath");
//         print("File Name: $fileName");
//         await Directory(exPath).create(recursive: false);

//         final path = exPath;

//         File file = File('$path/$fileName');

//         // Write the data in the file you have created
//         var res = await file.writeAsBytes(bytes.buffer.asUint8List());
//         print('Res::::::::$res');

//         print(await File('$path/$fileName').exists());
//         await SnakBarWidget.getSnackBarErrorBlueWith5Sec(AppMetaLabels().success,
//             AppMetaLabels().fileDownloadedSuccessfully);

//         return true;
//       } else {
//         await Permission.storage.request();
//       }
//       return true;
//     } catch (e) {
//       print('Exception :::: Inside the ::::: save func ${e.toString()}');
//       Get.snackbar(
//         AppMetaLabels().error,
//         e.message.toString(),
//         backgroundColor: AppColors.white54,
//       );
//       return false;
//     }
//   }

//   // create file for open
//   Future<String> createFile(Uint8List data, String fileName) async {
//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/$fileName");
//     await file.writeAsBytes(data.buffer.asUint8List());
//     return "${output.path}/$fileName";
//   }
// }
