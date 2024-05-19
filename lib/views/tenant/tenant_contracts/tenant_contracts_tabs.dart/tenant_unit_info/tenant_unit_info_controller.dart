import 'dart:typed_data';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/get_contract_units_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class UnitInfoController extends GetxController {
  var unitInfo = GetContractUnitsModel().obs;

  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;

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
    // try {
    loadingData.value = true;
    var result = await TenantRepository.getUnits();

    if (result is GetContractUnitsModel) {
      unitInfo.value = result;
      if (unitInfo.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        unitInfo.value = result;
        length = unitInfo.value.contractUnits.length;
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }
  }

  Stream<Uint8List> getImage(int index) async* {
    var resp = await TenantRepository.getUnitImage(
        unitInfo.value.contractUnits[index].unitId);
    if (resp is Uint8List) {
      yield resp;
    } else {
      throw Exception();
    }
  }
}
