import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_emirate_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LandlordFilterEmirateController extends GetxController {
  Rx<GetLandLordEmirateModel> propertyEmirateModel =
      GetLandLordEmirateModel().obs;
  RxBool loading = false.obs;
  RxString error = ''.obs;
  int propertyEmirateModelLength = 0;

  @override
  void onInit() {
    getEmirate();
    super.onInit();
  }

  void getEmirate() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    loading.value = true;
    var resp = await LandlordRepository.getEmirate();
    loading.value = false;
    print('Response ::::: $resp');
    if (resp == 'No data found') {
      error.value = resp;
    } else if (resp == 'Bad Request') {
      error.value = AppMetaLabels().someThingWentWrong;
    } else if (resp.status == 'Ok') {
      propertyEmirateModel.value = resp;
      propertyEmirateModelLength = resp.propertyEmirate.length;
    } else {
      error.value = resp;
    }
  }
}
