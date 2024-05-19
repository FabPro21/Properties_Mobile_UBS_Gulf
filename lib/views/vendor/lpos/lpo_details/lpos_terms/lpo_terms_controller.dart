import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_terms_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LpoTermsController extends GetxController {
  Rx<GetLpoTermsModel> getLpoTermsResp = GetLpoTermsModel().obs;
  RxBool scrolling = false.obs;
  RxBool loadingData = false.obs;
  RxString error = ''.obs;
  int length = 0;

  @override
  void onInit() {
    getLpoTerms();
    super.onInit();
  }

  void getLpoTerms() async {
    loadingData.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }

    var result = await VendorRepository.getLpoTerms();
    if (result is GetLpoTermsModel) {
      getLpoTermsResp.value = result;
      if (getLpoTermsResp.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        getLpoTermsResp.value = result;
        length = getLpoTermsResp.value.lpoTerms.length;
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }
  }
}
