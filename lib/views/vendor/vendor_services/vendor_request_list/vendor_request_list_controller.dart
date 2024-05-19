import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/chart_data.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

import '../../../../data/models/vendor_models/get_vendor_service_requests_model.dart';
import '../../../../data/repository/vendor_repository.dart';

class GetVendorServiceRequestsController extends GetxController {
  var getVendorServicesRequest = GetVendorServiceRequests().obs;

  var loadingData = true.obs;
  RxString error = "".obs;

  List<ServiceRequest> svcReqs = [];

  @override
  void onInit() {
    // getData();
    super.onInit();
  }

  RxInt open = 0.obs;
  RxInt close = 0.obs;
  List<ChartData> chartData;
  Future<void> getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await VendorRepository.getVendorServiceRequestsServices();
    loadingData.value = false;
    if (result is GetVendorServiceRequests) {
      if (result.serviceRequests.length == 0) {
        error.value = AppMetaLabels().noServiceRequestsFound;
      } else {
        getVendorServicesRequest.value = result;
        svcReqs = result.serviceRequests;
        open.value = 0;
        close.value = 0;
        for (int i = 0; i < svcReqs.length; i++) {
          if (svcReqs[i].status.contains('Close') ||
              svcReqs[i].status.contains('close') ||
              svcReqs[i].status.contains('Closed') ||
              svcReqs[i].status.contains('closed')) {
            close.value = close.value + 1;
          } else {
            open.value = open.value + 1;
          }
          var closeVal = close.value;
          var total = svcReqs.length;
          var progress = total - closeVal;
          chartData = [
            ChartData(AppMetaLabels().total, double.parse(total.toString()),
                AppColors.amber.withOpacity(0.2)),
            ChartData(AppMetaLabels().openReqs,
                double.parse(progress.toString()), AppColors.chartBlueColor),
          ];
        }
      }
    } else {
      error.value = result;
    }
  }

  String pageNo = '1';
  Future<void> getDataPagination(String pageNoP, searchtext) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    error.value = '';
    loadingData.value = true;
    var result =
        await VendorRepository.getVendorServiceRequestsServicesPagination(
            pageNoP, searchtext);
    loadingData.value = false;
    if (result is GetVendorServiceRequests) {
      if (result.serviceRequests.length == 0) {
        error.value = AppMetaLabels().noServiceRequestsFound;
      } else {
        getVendorServicesRequest.value = result;
        svcReqs = result.serviceRequests;
      }
    } else {
      error.value = result;
    }
  }

  RxString errorLoadMore = ''.obs;
  var loadingDataLoadMore = true.obs;
  Future<void> getDataPaginationLoadMore(String pageNoP, searchtext) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingDataLoadMore.value = true;
    errorLoadMore.value = '';
    var result =
        await VendorRepository.getVendorServiceRequestsServicesPagination(
            pageNoP, searchtext);
    loadingDataLoadMore.value = false;
    if (result is GetVendorServiceRequests) {
      if (result.serviceRequests.length == 0) {
        errorLoadMore.value = AppMetaLabels().noServiceRequestsFound;
      } else {
        getVendorServicesRequest.value = result;
        for (int i = 0;
            i < getVendorServicesRequest.value.serviceRequests.length;
            i++) {
          svcReqs.add(result.serviceRequests[i]);
        }
        update();
      }
    } else {
      errorLoadMore.value = result;
    }
  }

  searchData(String qry) {
    if (getVendorServicesRequest.value.serviceRequests != null) {
      qry = qry.toLowerCase();
      loadingData.value = true;
      List<ServiceRequest> _searchedSvc = [];
      for (int i = 0;
          i < getVendorServicesRequest.value.serviceRequests.length;
          i++) {
        if (getVendorServicesRequest.value.serviceRequests[i].category
                .toLowerCase()
                .contains(qry) ||
            getVendorServicesRequest.value.serviceRequests[i].propertyName
                .toLowerCase()
                .contains(qry) ||
            getVendorServicesRequest.value.serviceRequests[i].propertyNameAR
                .contains(qry) ||
            getVendorServicesRequest.value.serviceRequests[i].requestNo
                .toString()
                .contains(qry)) {
          _searchedSvc.add(getVendorServicesRequest.value.serviceRequests[i]);
        }
      }
      svcReqs = _searchedSvc.toList();
      if (svcReqs.length == 0)
        error.value = AppMetaLabels().noServiceRequestsFound;
      else
        error.value = '';

      loadingData.value = false;
    }
  }
}
