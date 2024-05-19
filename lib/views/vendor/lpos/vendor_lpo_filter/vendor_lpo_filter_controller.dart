import 'package:fap_properties/data/models/vendor_models/get_all_lpos_model.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_status_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:get/get.dart';

class VendorLpoFilterController extends GetxController {
  Rx<LpoStatus> lpoStatus = LpoStatus().obs;
  String propertyName = '';
  var fromDate = "".obs;
  var toDate = "".obs;
  var fromDateText = "".obs;
  var toDateText = "".obs;
  var filterError = "".obs;
  void resetValues() {
    propertyName = '';
    lpoStatus.value = LpoStatus();
    fromDate.value = "";
    toDate.value = "";
    fromDateText.value = "";
    toDateText.value = "";
    filterError.value = "";
  }
  // RxBool isFilter = false.obs;

  @override
  void onInit() {
    // DateTime now = DateTime.now();
    // fromDate.value = "${formatDate(now.month)}-${formatDate(now.day)}-${now.year - 1}";
    // toDate.value = "${formatDate(now.month)}-${formatDate(now.day)}-${now.year + 1}";
    super.onInit();
  }

  bool setFromDate(DateTime date) {
    // fromDate.value =
    //     "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
    // return true;
    if (toDate.value == '') {
      fromDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      fromDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      return true;
    }
    var splittedToDate = toDate.value.split('-');
    String date2 = splittedToDate[2] + splittedToDate[0] + splittedToDate[1];
    if (date.isBefore(DateTime.parse(date2))) {
      fromDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      fromDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      return true;
    } else {
      return false;
    }
  }

  bool setToDate(DateTime date) {
    // toDate.value =
    //     "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
    // return true;
    if (fromDate.value == '') {
      toDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      toDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      return true;
    }
    var splittedFromDate = fromDate.value.split('-');
    String date2 =
        splittedFromDate[2] + splittedFromDate[0] + splittedFromDate[1];
    if (date.isAfter(DateTime.parse(date2))) {
      toDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      toDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      return true;
    } else {
      return false;
    }
  }

  String formatDate(int num) {
    return (num < 10 ? "0" : "") + num.toString();
  }

  void goBack() {
    if (propertyName == '' &&
        lpoStatus.value.lpoStatusId == null &&
        fromDate.value == '' &&
        toDate.value == '') {
      filterError.value = AppMetaLabels().selectAtleastOne;
    } else if (fromDate.value == '' && toDate.value != '') {
      filterError.value = AppMetaLabels().selectFromDate;
    } else if (fromDate.value != '' && toDate.value == '') {
      filterError.value = AppMetaLabels().selectToDate;
    } else {
      filterError.value = '';

      if (lpoStatus.value.lpoStatusId == null) {
        lpoStatus.value.lpoStatusId = "-1";
      }

      Get.back(
          result: LpoFilterData(
              propName: propertyName,
              statusId: lpoStatus.value.lpoStatusId,
              dateFrom: fromDate.value,
              dateTo: toDate.value));
    }
  }
}
