import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_contract_stauts_model.dart'
    as contractStatus;
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LandlordFilterCSController extends GetxController {
  Rx<contractStatus.GetContractLandLordStatusModel> contractsStatusModel =
      contractStatus.GetContractLandLordStatusModel().obs;
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
    var resp = await LandlordRepository.getContractStatus();
    loading.value = false;

    if (resp == "No data found") {
      error.value = AppMetaLabels().noDatafound;
    } else if (resp.statusCode == 200) {
      contractsStatusModel.value = resp;
      if (resp.data != null) {
        contractsStatusLength = resp.data.length;
      }else{
        contractsStatusLength = 0;
      }
    } else {
      error.value = resp;
    }
  }
}
