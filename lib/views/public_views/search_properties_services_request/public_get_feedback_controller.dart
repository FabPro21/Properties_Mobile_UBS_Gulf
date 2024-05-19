import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_bookingreq_feedback/public_bookingreq_get_feedback_model.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class PublicGetFeedbackController extends GetxController {
  var getPublicfeedback = PublicBookingReqGetFeedbackModel().obs;
  var loadingData = false.obs;
  RxString onSearch = "".obs;
  RxString error = "".obs;

  Future<bool> getFeedback(caseNo) async {
    loadingData.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {

    error.value = '';
    var result = await PublicRepositoryDrop2.getPublicFeedback(caseNo);
    print(result);
    loadingData.value = false;
    if (result is PublicBookingReqGetFeedbackModel) {
      getPublicfeedback.value = result;
      return true;
      // Get.snackbar("Added", "Feedback Added Successfully");

    } else {
      error.value = result;
      return false;
    }
  }
}
