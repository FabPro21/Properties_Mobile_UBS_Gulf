import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_type_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LandLordFilterPropertyController extends GetxController {
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
      var resp;
      try {
        loading.value = true;
        resp = await LandlordRepository.getPropertyTypes();
        print('response ::::: $resp');
        loading.value = false;
        if (resp == 'No data found') {
          error.value = resp;
        } else if (resp == 'Bad Request') {
          error.value = AppMetaLabels().someThingWentWrong;
        } else if (resp.status == 'Ok') {
          propertyTypesModel.value = resp;
          proppertyTypesLength = resp.propertyType.length;
        } else {
          error.value = resp;
        }
      } catch (e) {
        print('Exception ::getPropertyTypes:::::   $e');
        print('Exception ::getPropertyTypes:::::   $resp');
      }
    }
  }
}
