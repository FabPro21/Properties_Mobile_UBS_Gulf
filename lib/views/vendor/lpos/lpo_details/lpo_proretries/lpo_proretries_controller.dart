import 'dart:typed_data';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_properties_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class GetLpoPropertiesController extends GetxController {
  var lpoProperties = GetLpoPropertiesModel().obs;

  var loadingData = false.obs;

  RxString onSearch = "".obs;
  RxString error = "".obs;
  int length = 0;

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
    var result = await VendorRepository.getLposProperties();

    if (result is GetLpoPropertiesModel) {
      lpoProperties.value = result;
      if (lpoProperties.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        lpoProperties.value = result;
        length = lpoProperties.value.lpoProperties!.length;
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }

    update();
    loadingData.value = false;
  }

  Stream<Uint8List> getImage(int index) async* {
    var resp = await TenantRepository.getPropertyImage(
        lpoProperties.value.lpoProperties![index].propertyID??0);
    if (resp is Uint8List) {
      yield resp;
    } else {
      throw Exception();
    }
  }
}
