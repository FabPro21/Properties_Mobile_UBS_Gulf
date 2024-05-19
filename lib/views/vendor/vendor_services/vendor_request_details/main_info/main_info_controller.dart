import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/photo_file.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:get/get.dart';

import '../../../../../data/models/vendor_models/get_vendor_service_request_details_model.dart';
import '../../vendor_request_list/vendor_request_list_controller.dart';

class SvcReqMainInfoController extends GetxController {
  var vendorRequestDetails = GetVendorServiceRequestDetailsModel().obs;
  var loadingData = true.obs;
  RxString error = "".obs;
  bool canCommunicate = true;

  //-----case status => ack / not in scope
  RxBool updatingStatus = false.obs;

  //--------photos---------
  RxBool gettingPhotos = false.obs;
  String errorGettingPhotos = '';
  List<PhotoFile> photos = [];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    canCommunicate = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result =
        await VendorRepository.getVendorDetailsServiceRequestsServices();
    loadingData.value = false;
    if (result is GetVendorServiceRequestDetailsModel) {
      vendorRequestDetails.value = result;
      if (result.detail.status.toLowerCase().contains('closed') ||
          result.detail.status.toLowerCase().contains('cancelled'))
        canCommunicate = false;
      getPhotos();
    } else {
      error.value = result;
    }
  }

  Future<void> getPhotos() async {
    photos.clear();
    errorGettingPhotos = '';
    gettingPhotos.value = true;
    var resp = await VendorRepository.getReqPhotos(
        vendorRequestDetails.value.detail.caseNo, 1);
    if (resp is List<PhotoFile>) {
      if (resp.length == 0) errorGettingPhotos = AppMetaLabels().noPhotos;
      photos = resp;
    } else
      errorGettingPhotos = AppMetaLabels().noPhotos;
    gettingPhotos.value = false;
  }

  void acknowledgeCase() async {
    updatingStatus.value = true;
    final response = await VendorRepository.acknowledgeCase(
        vendorRequestDetails.value.detail.caseNo);
    updatingStatus.value = false;
    if (response == 200) {
      SnakBarWidget.getSnackBarErrorBlue(
          AppMetaLabels().success, AppMetaLabels().statusUpdated);
      getData();
      final reqListController = Get.find<GetVendorServiceRequestsController>();
      reqListController.getData();
    } else {
      SnakBarWidget.getSnackBarErrorBlue(
        AppMetaLabels().error,
        AppMetaLabels().someThingWentWrong,
      );
    }
  }

  void rejectCase() async {
    updatingStatus.value = true;
    final response = await VendorRepository.rejectCase(
        vendorRequestDetails.value.detail.caseNo);
    updatingStatus.value = false;
    if (response == 200) {
      SnakBarWidget.getSnackBarErrorBlue(
        AppMetaLabels().success,
        AppMetaLabels().statusUpdated,
      );
      getData();
      final reqListController = Get.find<GetVendorServiceRequestsController>();
      reqListController.getData();
    } else {
      SnakBarWidget.getSnackBarErrorBlue(
        AppMetaLabels().error,
        AppMetaLabels().someThingWentWrong,
      );
    }
  }
}
