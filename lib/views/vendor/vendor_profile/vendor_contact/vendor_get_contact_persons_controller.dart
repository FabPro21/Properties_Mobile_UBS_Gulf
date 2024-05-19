import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_contact_persons_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class VendorGetContactPersonsController extends GetxController {
  var vendorContact = VendorGetContactPersonsModel().obs;

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
      var result = await VendorRepository.getContactPersons();
      if (result is VendorGetContactPersonsModel) {
        if (vendorContact.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          vendorContact.value = result;
          update();
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
    }
  }
}
