import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_contract_details_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VendorContractsDetailsController extends GetxController {
  var getContractsDetails = VendorGetContractDetailsModel().obs;

  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString amountCurrency = "".obs;
  RxString error = "".obs;
  int daysPassed = 0;
  double comPtg = 0.0;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingData.value = true;
      var result = await VendorRepository.getContractDetails();
      if (result is VendorGetContractDetailsModel) {
        getContractsDetails.value = result;
        if (getContractsDetails.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          getContractsDetails.value = result;
          var am = getContractsDetails.value.contractDetail.amount;
          final paidFormatter = NumberFormat('#,##0.00', 'AR');
          amountCurrency.value = paidFormatter.format(am);
          DateTime startDate =
              DateFormat('dd-mm-yyyy').parse(result.contractDetail.startDate);
          DateTime endDate =
              DateFormat('dd-mm-yyyy').parse(result.contractDetail.endDate);
          DateTime now = DateTime.now();
          int cLength = int.parse(result.contractDetail.contractLength);
          if (now.compareTo(startDate) <= 0) {
            daysPassed = 0;
            comPtg = 0;
          } else if (now.compareTo(endDate) >= 0) {
            daysPassed = cLength;
            comPtg = 1;
          } else {
            daysPassed = now.difference(startDate).inDays + 1;
            comPtg = daysPassed / cLength;
          }
          update();
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      print('Exception ::::: $e');
    }
  }
}
