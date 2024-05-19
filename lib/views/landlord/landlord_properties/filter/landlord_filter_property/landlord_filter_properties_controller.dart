import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_type_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LandLordFilterPropertiesController extends GetxController {
  Rx<GetLandLordPropertiesTypesModel> propertyTypesModel =
      GetLandLordPropertiesTypesModel().obs;
  RxBool loading = false.obs;
  RxString error = ''.obs;
  int proppertyTypesLength = 0;

  @override
  void onInit() {
    super.onInit();
  }

  void getPropertyTypes() async {
    if (propertyTypesModel.value.message == null) {
      bool _isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!_isInternetConnected) {
        await Get.to(NoInternetScreen());
      }
      loading.value = true;
      var resp = await LandlordRepository.getPropertyTypes();
      loading.value = false;
      if (resp.status == 'Ok') {
        propertyTypesModel.value = resp;
        proppertyTypesLength = resp.propertyType.length;
      } else {
        error.value = resp;
      }
    }
  }
}
