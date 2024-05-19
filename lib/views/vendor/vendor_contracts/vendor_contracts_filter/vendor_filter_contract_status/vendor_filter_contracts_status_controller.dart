import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_status_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class VendorFilterContractsStatusController extends GetxController {
  Rx<GetContractStatusModelVendor> contractsStatusModel =
      GetContractStatusModelVendor().obs;
  RxBool loading = false.obs;
  RxString error = ''.obs;
  int contractsStatusLength = 0;

  @override
  void onInit() {
    getContractsStatus();
    super.onInit();
  }

  void getContractsStatus() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    loading.value = true;
    var resp = await VendorRepository.getContractsStatusVendor();
    loading.value = false;

    if (resp is GetContractStatusModelVendor) {
      contractsStatusModel.value = resp;
      contractsStatusLength = resp.contractStatus.length;
    } else {
      error.value = resp;
    }
  }
}
