import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

import '../../../../data/models/public_models/get_property_category_model.dart';

class GetPropertyCategoryController extends GetxController {
  var getPropertyCategory = GetPropertyCategoryModel().obs;

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
    var result = await PublicRepositoryDrop2.getPropertyCategory();
    loadingData.value = false;
    if (result is GetPropertyCategoryModel) {
      getPropertyCategory.value = result;
      length = getPropertyCategory.value.propertyCategory.length;
      update();
    } else {
      error.value = result;
    }
  }
}
