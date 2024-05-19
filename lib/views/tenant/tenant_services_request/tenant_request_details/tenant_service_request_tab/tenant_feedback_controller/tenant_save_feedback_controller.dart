import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_feedback/tenant_save_feedback_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class TenantSaveFeedbackController extends GetxController {
  var saveTenantfeedback = TenantSaveFeedbackModel().obs;

  var loadingData = true.obs;

  RxString onSearch = "".obs;
  RxString error = "".obs;
  RxDouble rating = 0.0.obs;

  Future<void> saveFeedback(description, casedId) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    error.value = '';
    var result = await TenantRepository.saveTenantSRFeedback(
        casedId, description, rating.value);
    print(result);
    loadingData.value = false;
    if (result is TenantSaveFeedbackModel) {
      saveTenantfeedback.value = result;
    } else {
      error.value = result;
    }
  }
}
