import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/get_property_types_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class FilterPropertyController extends GetxController {
  Rx<GetPropertyTypesModel> propertyTypesModel = GetPropertyTypesModel().obs;
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
      var resp = await TenantRepository.getPropertyTypes();
      loading.value = false;

      if (resp is GetPropertyTypesModel) {
        propertyTypesModel.value = resp;
        proppertyTypesLength = resp.propertyTypes.length;
      } else {
        error.value = resp;
      }
    }
  }
}
