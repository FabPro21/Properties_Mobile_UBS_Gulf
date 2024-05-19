// ignore_for_file: invalid_use_of_protected_member

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:get/get.dart';

class LandlordReportController extends GetxController {
  List<String> apiListData = [
    "Building Status Report", // Done With Sir 1
    "Unit Status Report", // Done With Sir 2
    "Tenancy Contracts Report", // Done With Sir 3
    "Receipt Register Report", // Done With Sir 4
    "Cheque Register Report", // Done With Sir 5 but download not working
    "Occupancy Vacancy Register Report", //  Done With Sir 6
    "Legal Case Report", // need to work with sir
    "VAT Report", // 8 14 March Not Done
    "AMC Report", // 9 14 March Not Done
    "LPO Report", // Done With Sir 10
    // "Building Expense Report", // Not Done 11
  ];
  List<String> apiListDataAr = [
    'تقرير حالة المبنى' // 1
        "تقرير حالة الوحدة", // 2
    "تقرير العقود", // 3
    "تقرير سجل الاستلام", // 4
    "تحقق من تسجيل التقرير", // 5
    "تقرير سجل الوظائف الشاغرة", // 6
    "تقرير الحالة القانونية", // 7
    "تقرير ضريبة القيمة المضافة", // 8
    "تقرير AMC", // 9
    "تقرير LPO", // 10
    // "تقرير مصاريف البناء", // Not Done 11
  ];
  // List<String> apiListData = [
  //   "Cheque Register Report", // Done With Sir 5
  //   "Legal Case Report", // Done After All Testing 7
  //   "Receipt Register Report", // Done After All Testing 4
  //   "Occupancy Vacancy Register Report", //  Done With Sir 6
  //   "Contracts Report", // OK 3 must update in code
  //   "AMC Report", // Not Ok 9
  //   "LPO Report", // Not Ok 10
  //   // "Building Expense Report", // Not Ok 11
  //   "VAT Report", // Ok 8
  //   "Unit Status Report", // Not Ok 2
  //   "Building Status Report", // Not Ok 1
  // ];
  // List<String> apiListDataAr = [
  //   "تحقق من تسجيل التقرير", // Done 5
  //   "تقرير الحالة القانونية", // Done 7
  //   "تقرير سجل الاستلام", // Done 4
  //   "تقرير سجل الوظائف الشاغرة", // Not Done 6
  //   "تقرير العقود", // Not Done 3
  //   "تقرير AMC", // Done 9
  //   "تقرير LPO", // Done 10
  //   // "تقرير مصاريف البناء", // Not Done 11
  //   "تقرير ضريبة القيمة المضافة", // Done 8
  //   "تقرير حالة الوحدة", // Done 2
  //   'تقرير حالة المبنى' // 1
  // ];

  RxBool isLoading = false.obs;
  RxString errorLoadingReport = ''.obs;
  List reportsList = [];
  List reportsListAR = [];
  makeLoading() async {
    isLoading.value = true;
    reportsList.clear();
    await Future.delayed(Duration(seconds: 1));
    if (SessionController().getLanguage() == 1) {
      for (int i = 0; i < apiListData.length; i++) {
        reportsList.add(apiListData[i]);
      }
    } else {
      for (int i = 0; i < apiListDataAr.length; i++) {
        reportsListAR.add(apiListDataAr[i]);
      }
    }
    isLoading.value = false;
  }

  searchData(String qry) {
    isLoading.value = true;
    List<String> _searchedCont = [];
    for (int i = 0; i < apiListData.length; i++) {
      print('Report Result :::: ${apiListData[i].contains(qry)}');
      if (apiListData[i].toLowerCase().contains(qry.toLowerCase())) {
        _searchedCont.add(apiListData[i]);
      }
    }
    reportsList = _searchedCont.toList();
    if (reportsList.length == 0)
      errorLoadingReport.value = AppMetaLabels().noDatafound;
    else
      errorLoadingReport.value = '';

    isLoading.value = false;
  }
}
