import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_bookingreq_feedback/public_bookingreq_feedback_model.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class PublicSaveFeedbackController extends GetxController {
  var savePublicfeedback = PublicBookingReqSaveFeedbackModel().obs;

  var loadingData = false.obs;

  RxString onSearch = "".obs;
  RxString error = "".obs;
  RxDouble rating = 0.0.obs;

  Future<bool> saveFeedback(description, casedId) async {
    loadingData.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {

    error.value = '';
    print(rating.value);
    var result = await PublicRepositoryDrop2.savePublicFeedback(
        casedId, description, rating.value);
    print(result);
    loadingData.value = false;
    if (result is PublicBookingReqSaveFeedbackModel) {
      savePublicfeedback.value = result;
      return true;
    } else {
      error.value = result;
      return false;
    }
  }
}
