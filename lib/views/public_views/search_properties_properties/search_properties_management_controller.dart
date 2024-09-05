import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_property_management/public_property_management_model.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class PublicGetpropertyMangementController extends GetxController {
  var getdata = PublicGetPropertyManagementModel().obs;
  var loadingData = true.obs;
  RxString error = "".obs;
  int length = 0;

  @override
  void onInit() {
    getPropertyManagement();
    super.onInit();
  }

  Future<void> getPropertyManagement() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      loadingData.value = true;
      var result = await PublicRepositoryDrop2.publicPropertyManagement();
      print(result);
      loadingData.value = false;
      if (result is PublicGetPropertyManagementModel) {
        getdata.value = result;
        length = getdata.value.record!.length;
        loadingData.value = false;
      } else {
        error.value = result;
        loadingData.value = false;
      }
    } catch (e) {
      print("This is the error from controller $e");
      loadingData.value = false;
    }
  }
}
