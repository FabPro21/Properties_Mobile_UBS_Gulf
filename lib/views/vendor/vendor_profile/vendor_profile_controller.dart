import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_profile_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class VendorProfileController extends GetxController {
  var vendorProfile = VendorGetProfileModel().obs;

  var loadingData = true.obs;
  RxString error = ''.obs;

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
      var result = await VendorRepository.getProfile();
      loadingData.value = false;
      if (result is VendorGetProfileModel) {
        if (vendorProfile.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          vendorProfile.value = result;
          loadingData.value = false;
          update();
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      print("this is the error from controller= $e");
      loadingData.value = false;
    }
  }
}
