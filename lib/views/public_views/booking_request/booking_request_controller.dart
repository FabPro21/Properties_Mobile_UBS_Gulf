import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_booking_request/public_booking_request_agentlist_model.dart';
import 'package:fap_properties/data/models/public_models/public_booking_request/public_save_booking_request_model.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:get/get.dart';

class BookingRequestController extends GetxController {
  var selectAgent = PublicBookingRequestAgentModel().obs;
  var saveBookingReq = PublicSaveBookingRequestModel().obs;

  var loadingAgent = true.obs;
  int lengthAgent = 0;
  RxString onSearch = "".obs;
  RxString errorAgent = "".obs;
  var loadingSaveBooking = false.obs;
  RxString errorSaveBooking = "".obs;
  RxString agentId = "".obs;
  RxString agentName = AppMetaLabels().pleaseSelect.obs;
  RxBool invalidInput = false.obs;

  @override
  void onInit() {
    getAgent();
    super.onInit();
  }

  Future<void> getAgent() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingAgent.value = true;
    var result = await PublicRepositoryDrop2.getPublicBookingAgent();
    loadingAgent.value = false;
    if (result is PublicBookingRequestAgentModel) {
      selectAgent.value = result;
      lengthAgent = selectAgent.value.agentList!.length;
      print('Length of Agent List :::: $lengthAgent');
      print('Length of Agent List :::: ${selectAgent.value.agentList}');
    } else {
      errorAgent.value = result;
    }
  }

  Future<dynamic> saveBookingRequestData(propertyID, description,
      contractUnitId, otherContactPersonName, otherContactPersonMobile) async {
    loadingSaveBooking.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      var result = await PublicRepositoryDrop2.savePublicBookingRequest(
          propertyID,
          description,
          contractUnitId,
          otherContactPersonName,
          otherContactPersonMobile,
          agentId.value);
      loadingSaveBooking.value = false;
      if (result is PublicSaveBookingRequestModel) {
        saveBookingReq.value = result;
        SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().saved, AppMetaLabels().requestAddedSuccessfully);
        // Get.snackbar(
        //     AppMetaLabels().saved, AppMetaLabels().requestAddedSuccessfully);
        return result.addServiceRequest!.caseNo;
        // Get.to(()=>PublicServiceRequestList());

      } else {
        errorSaveBooking.value = result;
        SnakBarWidget.getSnackBarErrorBlue(AppMetaLabels().error, result);
        return null;
      }
    } catch (e) {
      print(e);
      loadingSaveBooking.value = false;
      return null;
    }
  }
}
