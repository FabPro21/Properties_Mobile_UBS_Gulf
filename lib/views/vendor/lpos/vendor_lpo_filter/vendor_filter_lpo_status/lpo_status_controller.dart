import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_status_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LpoStatusController extends GetxController {
  Rx<GetLpoStatusModel> lpoStatusModel = GetLpoStatusModel().obs;
  RxBool loading = false.obs;
  RxString error = ''.obs;
  int lpoStatusLength = 0;

  @override
  void onInit() {
    getLpoStatus();
    super.onInit();
  }

  void getLpoStatus() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    loading.value = true;
    var resp = await VendorRepository.getLpoStatus();
    loading.value = false;

    if (resp is GetLpoStatusModel) {
      lpoStatusModel.value = resp;
      lpoStatusLength = resp.lpoStatus!.length;
    } else {
      error.value = resp;
    }
  }
}
