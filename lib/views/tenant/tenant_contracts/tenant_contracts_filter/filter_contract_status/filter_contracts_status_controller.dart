import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/get_contracts_status_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class FilterContractsStatusController extends GetxController {
  Rx<GetContractStatusModel> contractsStatusModel =
      GetContractStatusModel().obs;
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
    var resp = await TenantRepository.getContractStatus();
    loading.value = false;

    if (resp is GetContractStatusModel) {
      contractsStatusModel.value = resp;
      contractsStatusLength = resp.contractStatus!.length;
    } else {
      error.value = resp;
    }
  }
}
