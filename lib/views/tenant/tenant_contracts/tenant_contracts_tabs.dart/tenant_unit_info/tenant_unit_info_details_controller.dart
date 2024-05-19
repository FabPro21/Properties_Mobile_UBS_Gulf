import 'dart:typed_data';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/get_contract_unit_details_model.dart';
import 'package:fap_properties/data/models/tenant_models/get_unit_aditional_details_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class TenantUnitInfoDetailsController extends GetxController {
  var unitDetails = GetContractUnitDetailsModel().obs;
  var loadingData = true.obs;
  RxString error = "".obs;
  var propertyImageInByte;
  int length = 0;

  var additionalUnitDetails = GetUnitAditionalDetailsModel().obs;
  var loadingAdditionalData = false.obs;
  var errorLoadingAdditional = ''.obs;

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
    loadingData.value = true;
    var result = await TenantRepository.getContractUnitDetails();

    if (result is GetContractUnitDetailsModel) {
      if (unitDetails.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
      } else {
        unitDetails.value = result;
        await getAdditionalData();
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
    }
  }

  getAdditionalData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    loadingAdditionalData.value = true;
    var result = await TenantRepository.getUnitAditionalDetails();
    loadingAdditionalData.value = false;
    loadingData.value = false;
    print('Result of the getAdditionalData ********** $result ');
    if (result is GetUnitAditionalDetailsModel) {
      if (additionalUnitDetails.value.status == AppMetaLabels().notFound) {
        errorLoadingAdditional.value = AppMetaLabels().noDatafound;
      } else {
        additionalUnitDetails.value = result;
        length = additionalUnitDetails.value.additionalInfo.length;
      }
    } else {
      errorLoadingAdditional.value = AppMetaLabels().noDatafound;
    }
  }

  Stream<Uint8List> getImage() async* {
    var resp = await TenantRepository.getUnitImage(
        unitDetails.value.contractUnit.unitId);
    if (resp is Uint8List) {
      yield resp;
    } else {
      throw Exception();
    }
  }
}
