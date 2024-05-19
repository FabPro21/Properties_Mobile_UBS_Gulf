import 'dart:convert';
import 'dart:developer';
import 'package:fap_properties/data/models/landlord_models/download_report_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_download_report.dart';
import 'package:fap_properties/data/models/landlord_models/report/get_dropdown_model.dart';
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
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import '../../helpers/base_client.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

class LandlordDownloadReportServices {
  static Future<dynamic> downloadReportFile(String fileName, Map data) async {
    var url;
    if (fileName == "Cheque Register Report") {
      url = AppConfig().downloadGenerateChequeRegisterReport;
    } else if (fileName == "Legal Case Report") {
      url = AppConfig().downloadGenerateLegalCaseReport;
    } else if (fileName == "Receipt Register Report") {
      url = AppConfig().downloadGenerateReceiptRegisterReport;
    }
    // else if (fileName == "Occupancy Vacancy Register Report") {
    //   url = AppConfig().;
    // }
    else if (fileName == "Unit Status Report") {
      url = AppConfig().downloadGenerateUnitStatusReport;
    } else if (fileName == "AMC Report") {
      url = AppConfig().downloadAMCReport;
    } else if (fileName == "LPO Report") {
      url = AppConfig().downloadGenerateLPOReport;
    } else if (fileName == "Building Expense Report") {
      url = AppConfig().downloadGenerateBERReport;
    } else if (fileName == "Tenancy Contracts Report") {
      url = AppConfig().downloadGenerateLandLordGetContracts;
    } else {
      url = AppConfig().downloadGenerateVATReport;
    }
    print('URL :::::::: $url');
    print('Data :::::::: $data');
    var response = await BaseClientClass.post(url, data);
    try {
      if (response is Response) {
        log(response.body);
        return DownloadReportModel.fromJson(jsonDecode(response.body));
      } else
        return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().someThingWentWrong;
    }
  }

  static Future<dynamic> downloadReportFileBase64(
      String fileName, Map data) async {
    var url;
    if (fileName == "Cheque Register Report") {
      url = AppConfig().downloadGenerateChequeRegisterReport;
    } else if (fileName == "Legal Case Report") {
      url = AppConfig().downloadGenerateLegalCaseReport;
    } else if (fileName == "Receipt Register Report") {
      url = AppConfig().downloadGenerateReceiptRegisterReport;
    } else if (fileName == "Unit Status Report") {
      url = AppConfig().downloadGenerateUnitStatusReport;
    } else if (fileName == "AMC Report") {
      url = AppConfig().downloadAMCReport;
    } else if (fileName == "LPO Report") {
      url = AppConfig().downloadGenerateLPOReport;
    } else if (fileName == "Building Expense Report") {
      url = AppConfig().downloadGenerateBERReport;
    } else if (fileName == "Tenancy Contracts Report") {
      url = AppConfig().downloadGenerateLandLordGetContracts;
    } else if (fileName == "Building Status Report") {
      url = AppConfig().downloadGenerateBuildingStatusReport;
    } else if (fileName == 'Occupancy Vacancy Register Report') {
      url = AppConfig().occupancyVacancyRegisterReport;
    } else if (fileName == 'Legal Case Report') {
      url = AppConfig().generateLegalCaseReport;
    } else if (fileName == 'Tenancy Contracts Report') {
      url = AppConfig().generateContractReport;
    } else {
      url = AppConfig().downloadGenerateVATReport;
    }
    print('URL :::::1122::: $url');
    print('Data :::::1122::: $data');

    var response = await BaseClientClass.post(url, data);
    if (response is Response) {
      try {
        var result =
            LandlordDownloadReportModel.fromJson(jsonDecode(response.body));
        return result;
      } catch (e) {
        print('*************************** :: $e');
        return AppMetaLabels().someThingWentWrong;
      }
    }
    print('*************************** :: $response');
    return response;
  }

  // get drop down type Report
  static Future<dynamic> getDropDownType(String type) async {
    var url = AppConfig().getDropDownType;
    Map data = {"dropdownTypeID": type};
    var response = await BaseClientClass.post(url, data);
    if (response is Response) {
      try {
        var resp = GetDropDownModel.fromJson(jsonDecode(response.body));
        print('resp*************************** :: $resp');
        return resp;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }

  // getAMcSummary Report
  static Future<dynamic> getAMCreportSummary(Map data) async {
    var url = AppConfig().generateAMCReportSummary;

    print('Url ::::::::: $url');
    print('Data ::::::::: $data');

    var response = await BaseClientClass.post(url, data);
    if (response is Response) {
      log(response.body);
      try {
        var resp = AMCReportSummaryModel.fromJson(jsonDecode(response.body));
        print('Resp after convert getAMCreportSummary:$resp');
        return resp;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }

  // generate Report summary
  static Future<dynamic> getreportSummary(Map data, String reportName) async {
    var url;
    if (reportName == 'LPO Report') {
      url = AppConfig().generateLPOReportSummary;
    } else if (reportName == 'AMC Report') {
      url = AppConfig().generateAMCReportSummary;
    } else if (reportName == 'Cheque Register Report') {
      url = AppConfig().generateChequeRegisterReportSummary;
    } else if (reportName == 'VAT Report') {
      url = AppConfig().generateVATReportSummary;
    } else if (reportName == 'Receipt Register Report') {
      url = AppConfig().generateReceiptRegisterReportSummary;
    } else if (reportName == 'Unit Status Report') {
      url = AppConfig().generateUnitStatusReportSummary;
    } else if (reportName == 'Building Status Report') {
      url = AppConfig().generateBuildingStatusReportSummary;
    } else if (reportName == 'Occupancy Vacancy Register Report') {
      url = AppConfig().occupancyVacancyRegisterSummary;
    } else if (reportName == 'Legal Case Report') {
      url = AppConfig().generateLegalCaseReportSummary;
    } else if (reportName == 'Tenancy Contracts Report') {
      url = AppConfig().generateContractReportSummary;
    } else {
      url = AppConfig().generateAMCReportSummary;
    }

    print('URL :::::112233::: $url');
    print('Data :::::112233::: $data');

    var response = await BaseClientClass.post(url, data);
    if (response is Response) {
      try {
        // 1
        if (reportName == 'AMC Report') {
          var result = getAMCReportSUmmaryModelFromJson(response.body);
          print(
              'Result  Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        }
        // 2
        else if (reportName == 'Building Status Report') {
          var result = getBuildingStatusSummaryModelFromJson(response.body);
          print(
              'Result Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        }
        // 3
        else if (reportName == 'Cheque Register Report') {
          var result = getChequeRegisterReportModelFromJson(response.body);
          print(
              'Result Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        }
        // 4
        else if (reportName == 'Tenancy Contracts Report') {
          var result = getContractSUmmaryModelFromJson(response.body);
          print(
              'Result Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        }
        // 5
        else if (reportName == 'Legal Case Report') {
          var result = getLeglCaseReportModelFromJson(response.body);
          print(
              'Result Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        }
        // 6
        else if (reportName == 'Occupancy Vacancy Register Report') {
          var result = getOcupanyReportSUmmaryModelFromJson(response.body);
          print(
              'Result Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        }
        // 7
        else if (reportName == 'Receipt Register Report') {
          var result = getReceiptRegisterReportModelFromJson(response.body);
          print(
              'Result Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        }
        // 8
        else if (reportName == 'Unit Status Report') {
          var result = getUnitStatusReportModelFromJson(response.body);
          print(
              'Result Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        }
        // 9
        else if (reportName == 'VAT Report') {
          var result = getVATReportSummaryModelFromJson(response.body);
          print(
              'Result Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        }
        // 10
        else if (reportName == 'LPO Report') {
          var result = getLpoReportSummaryModelFromJson(response.body);
          print(
              'Result Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        } else {
          var result = getAMCReportSUmmaryModelFromJson(response.body);
          print(
              'Result  Repo:::$reportName::: ${result.serviceRequests.length}');
          return result;
        }
      } catch (e) {
        print('Resp after convert Error * 1 $e');
        print('Resp after convert Error ${e.message}');
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }

  // getLPOSummary Report
  static Future<dynamic> getLPOSummary(Map data) async {
    var url = AppConfig().generateLPOReportSummary;
    print('Url ::::::::: $url');
    print('Data ::::::::: $data');
    var response = await BaseClientClass.post(url, data);
    if (response is Response) {
      try {
        var resp = AMCReportSummaryModel.fromJson(jsonDecode(response.body));
        print('Resp after convert getLPOSummary:$resp');
        return resp;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
