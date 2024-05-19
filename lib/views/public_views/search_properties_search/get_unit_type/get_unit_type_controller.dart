import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

import '../../../../data/models/public_models/get_unit_type_model.dart';

class GetUnitTypeController extends GetxController {
  var getUnitType = GetUnitTypeModel().obs;

  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;
  var showArea;

  // @override
  // void onInit() {
  //   getData();
  //   super.onInit();
  // }

  Future<void> getData(category) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await PublicRepositoryDrop2.getUnitType(category);
    loadingData.value = false;
    if (result is GetUnitTypeModel) {
      getUnitType.value = result;
      error.value = "";
      length = getUnitType.value.unitTypes.unitTypes.length;

      showArea = getUnitType.value.unitTypes.showArea;
      // 112233 show area
      SessionController().showArea.value = getUnitType.value.unitTypes.showArea;
      update();
    } else {
      error.value = result;
    }
  }
}
