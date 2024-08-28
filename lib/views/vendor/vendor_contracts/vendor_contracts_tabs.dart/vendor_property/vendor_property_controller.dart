import 'dart:typed_data';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_contract_prop_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class VendorPropertiesController extends GetxController {
  var vendorProperty = VendorGetContractPropModel().obs;

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
    try {
      loadingData.value = true;
      var result = await VendorRepository.getContractProps();
      if (result is VendorGetContractPropModel) {
        vendorProperty.value = result;
        if (vendorProperty.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          vendorProperty.value = result;
          length = vendorProperty.value.contractProperties!.length;
          update();
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      print("this is the error from controller= $e");
    }
  }

  Stream<Uint8List> getImage(int index) async* {
    try {
      var resp = await VendorRepository.getPropertyImage(
          vendorProperty.value.contractProperties![index].propertyId);
      if (resp is Uint8List) {
        yield resp;
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
    }
  }
}
