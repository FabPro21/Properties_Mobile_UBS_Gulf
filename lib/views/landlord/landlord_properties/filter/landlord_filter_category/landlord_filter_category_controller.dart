import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_category_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LandLordFilterCategoryController extends GetxController {
  Rx<GetLandLordCategoryModel> propertyCategoryModel =
      GetLandLordCategoryModel().obs;
  RxBool loading = false.obs;
  RxString error = ''.obs;
  int propertyCategoryModelLength = 0;

  @override
  void onInit() {
    super.onInit();
  }

  void getPropertyCategory() async {
    if (propertyCategoryModel.value.message == null) {
      bool _isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!_isInternetConnected) {
        await Get.to(NoInternetScreen());
      }
      loading.value = true;
      var resp = await LandlordRepository.getPropertyCategory();
      loading.value = false;
      if (resp == 'No data found') {
        error.value = resp;
      } else if (resp == 'Bad Request') {
        error.value = AppMetaLabels().someThingWentWrong;
      } else if (resp.status == 'Ok') {
        propertyCategoryModel.value = resp;
        propertyCategoryModelLength = resp.proppertyCategoris.length;
      } else {
        error.value = resp;
      }
    }
  }
}
