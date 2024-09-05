import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_add_request/get_tenant_properties_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class GetTenantPropertiesController extends GetxController {
  var getTenantProperties = GetTenantPropertiesModel().obs;

  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await TenantRepository.getTenantUnits();
    loadingData.value = false;
    if (result is GetTenantPropertiesModel) {
      getTenantProperties.value = result;
      print(result);
      length = getTenantProperties.value.properties!.length;
      update();
    } else {
      error.value = result;
    }
  }
}
