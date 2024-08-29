// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/filter_data.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/get_contracts_status_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/get_property_types_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:get/get.dart';

class TenantContracrsFilterController extends GetxController {
  String propertyName = '';
  Rx<PropertyType> propType = PropertyType().obs;
  Rx<ContractStatus> contractStatus = ContractStatus().obs;
  var fromDate = "".obs;
  var toDate = "".obs;
  var fromDateText = "".obs;
  var toDateText = "".obs;
  var filterError = "".obs;
  void resetValues() {
    propertyName = '';
    propType.value = PropertyType();
    contractStatus.value = ContractStatus();
    fromDate.value = '';
    toDate.value = '';
    fromDateText.value = '';
    toDateText.value = '';
  }

  @override
  void onInit() {
    super.onInit();
  }

  bool setFromDate(DateTime date) {
    if (toDate.value == '') {
      fromDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      fromDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      filterError.value = '';
      return true;
    }
    var splittedToDate = toDate.value.split('-');
    String date2 = splittedToDate[2] + splittedToDate[0] + splittedToDate[1];
    if (date.isBefore(DateTime.parse(date2))) {
      fromDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      fromDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      filterError.value = '';
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
      filterError.value = '';
      return true;
    }
    var splittedFromDate = fromDate.value.split('-');
    String date2 =
        splittedFromDate[2] + splittedFromDate[0] + splittedFromDate[1];
    if (date.isAfter(DateTime.parse(date2)) ||
        date.isAtSameMomentAs(DateTime.parse(date2))) {
      toDate.value =
          "${formatDate(date.month)}-${formatDate(date.day)}-${date.year}";
      toDateText.value =
          "${formatDate(date.day)}-${formatDate(date.month)}-${date.year}";
      filterError.value = '';
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
        propType.value.propertyTypeId == null &&
        contractStatus.value.contractTypeId == null &&
        fromDate.value == '' &&
        toDate.value == '') {
      filterError.value = AppMetaLabels().selectAtleastOne;
    } else if (fromDate.value == '' && toDate.value != '') {
      filterError.value = AppMetaLabels().selectFromDate;
    } else if (fromDate.value != '' && toDate.value == '') {
      filterError.value = AppMetaLabels().selectToDate;
    } else {
      filterError.value = '';
      dynamic pti = propType.value.propertyTypeId;
      dynamic csi = contractStatus.value.contractTypeId;

      if (pti == null) {
        pti = "-1";
      }
      if (csi == null) {
        csi = "-1";
      }
      Get.back(
        result: FilterData(
          propertyName,
          pti,
          csi,
          fromDate.value,
          toDate.value,
        ),
      );
    }
  }
}
