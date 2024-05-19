import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_add_request/save_services_request_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request/add_new_service_request/add_photos/add_request_photos.dart';
import 'package:get/get.dart';

import '../../../../../data/repository/tenant_repository.dart';

class TenantAddServicesRequestController extends GetxController {
  var model = SaveServiceRequestModel().obs;

  RxString caseCategoryName = AppMetaLabels().pleaseSelect.obs;
  RxString caseCategoryId = ''.obs;

  RxString caseSubCategoryName = AppMetaLabels().pleaseSelect.obs;
  RxString caseSubCategoryId = ''.obs;

  RxString contractUnitName = AppMetaLabels().pleaseSelect.obs;
  RxString contractUnitId = ''.obs;

  RxString preferredTime = AppMetaLabels().pleaseSelect.obs;
  RxString preferredTimeId = ''.obs;

  RxString serviceType = ''.obs;

  String contactName = '';
  String contactMobile = '';
  String remarks = '';

  var loadingData = false.obs;
  RxString error = "".obs;

  RxBool otherThanTenant = false.obs;

  RxBool invalidInput = false.obs;

  Future<void> submitRequest() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {

    error.value = '';
    loadingData.value = true;
    var result = await TenantRepository.saveServiceRequest(
        caseCategoryId.value,
        caseSubCategoryId.value,
        contractUnitId.value,
        remarks,
        contactName.isEmpty ? null : contactName,
        contactMobile.isEmpty ? null : contactMobile,
        preferredTimeId.value.isEmpty ? null : preferredTimeId.value);
    loadingData.value = false;
    if (result is SaveServiceRequestModel) {
      model.value = result;
      SessionController()
          .setCaseNo(model.value.addServiceRequest.caseNo.toString());
      print(
          'Case No :::Before move toward ADDPhoto From Model::: ${model.value.addServiceRequest.caseNo.toString()}');
      print(
          'Case No :::Before move toward ADDPhoto From Session::: ${SessionController().getCaseNo()}');
      await Get.off(() => AddRequestPhotos(
            caseNo: model.value.addServiceRequest.caseNo.toString(),
          ));
      Get.back(result: 'added');
      update();
    } else {
      Get.snackbar(
        AppMetaLabels().error,
        result,
        backgroundColor: AppColors.white54,
      );
      error.value = result;
      loadingData.value = false;
    }
  }
}
