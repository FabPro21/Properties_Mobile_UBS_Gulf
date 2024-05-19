import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_properties_response.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_data_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/vendor/lpos/vendor_lpo_filter/vendor_filter_lpo_status/lpo_status_controller.dart';
import 'package:fap_properties/views/vendor/lpos/vendor_lpo_filter/vendor_lpo_filter_controller.dart';
import 'package:fap_properties/views/vendor/vendor_contracts/vendor_contracts_filter/vendor_contracts_filter_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/chart_data.dart';

class VendorDashboardController extends GetxController {
  Rx<VendorGetDataModel> getDataModel = VendorGetDataModel().obs;
  RxBool loadingData = true.obs;
  RxString error = ''.obs;
  Rx<GetLpoPropertiesResponse> getLpoPropResponse =
      GetLpoPropertiesResponse().obs;
  RxBool loadingLpo = false.obs;
  RxString lpoLoadingError = ''.obs;
  RxString shortName = ''.obs;
  RxString totalContractValues = "".obs;
  RxString company = "".obs;
  RxString companyAr = "".obs;

  List<ChartData> chartData;

  @override
  void onInit() {
    Get.put(VendorContractsFilterController());
    // 112233 commenting beause we are getting bad request
    // when this call on onint of VendorFilterContractsStatusController
    // Get.put(VendorFilterContractsStatusController());
    Get.put(VendorLpoFilterController());
    Get.put(LpoStatusController());
    // moving this to init coz we want it should reload when move in tabs
    // getData();
    super.onInit();
  }

  void getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    loadingData.value = true;
    var result = await VendorRepository.getData();
    loadingData.value = false;

    print('----------------------------');
    print(result);
    print('----------------------------');
    if (result is VendorGetDataModel) {
      if (getDataModel.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        getDataModel.value = result;
        company.value = getDataModel.value.dashboard.company ?? "";
        companyAr.value = getDataModel.value.dashboard.companyAr ?? "";
        dynamic am = getDataModel.value.dashboard.totalContractValues;
        final paidFormatter = NumberFormat('#,##0.00', 'AR');
        totalContractValues.value = paidFormatter.format(am);
        setData();
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }
  }

  void setData() {
    var name = getDataModel.value.dashboard.name.split(' ');
    if (name.isNotEmpty) {
      for (int i = 0; i < name.length; i++) {
        shortName.value = shortName + name[i];
        // .split('')[0].toUpperCase();
        // shortName.value = shortName + name[i].split('')[0].toUpperCase();
      }
    }
    double totALLPO = getDataModel.value.dashboard.totalLpo.toDouble();
    
    double lPOInProgress = getDataModel.value.dashboard.lpoInProcess.toDouble();

    chartData = [
      ChartData(AppMetaLabels().totalLpos, totALLPO,
          AppColors.amber.withOpacity(0.2)),
      ChartData(AppMetaLabels().activeLpos, lPOInProgress,
          AppColors.chartBlueColor),
    ];
  }
}
