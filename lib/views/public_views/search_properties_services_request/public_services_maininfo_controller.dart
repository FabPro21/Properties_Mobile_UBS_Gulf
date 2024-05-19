import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_cancel_bookingreq/public_cancel_bookingreq_model.dart';
import 'package:fap_properties/data/models/public_models/public_services_myrequest/public_service_maininfo_model.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

import 'public_service_request_controller.dart';

class PublicServiceMaininfoController extends GetxController {
  var publicMaininfoDetails = PublicServiceMainInfoModel().obs;
  var publicCancelRequest = PublicCancelBookingRequestModel();
  var _controller = Get.put(PublicServiceRequestController());
  var loadingData = true.obs;
  RxString onSearch = "".obs;
  RxString error = "".obs;

  RxBool cancellingRequest = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getServiceMaininfo(int caseno) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await PublicRepositoryDrop2.getServiceMainInfo(caseno);
    loadingData.value = false;
    if (result is PublicServiceMainInfoModel) {
      publicMaininfoDetails.value = result;
    } else {
      error.value = result;
    }
  }

  Future<void> cancelRequest(int caseNo) async {
    cancellingRequest.value = true;
    var resp = await PublicRepositoryDrop2.cancelBookingRequest(caseNo);
    cancellingRequest.value = false;
    if (resp is PublicCancelBookingRequestModel) {
      if (resp.status == 'Ok') {
        getServiceMaininfo(publicMaininfoDetails.value.detail.caseNo);
        _controller.getSericeRequest();
      } else
        Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().requestNotCancelled,
          backgroundColor: AppColors.white54,
        );
      cancellingRequest.value = false;
    } else
      Get.snackbar(
        AppMetaLabels().error,
        AppMetaLabels().someThingWentWrong,
        backgroundColor: AppColors.white54,
      );
    cancellingRequest.value = false;
  }
}
