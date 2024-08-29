import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

import '../../../data/models/public_models/public_properties_service/public_Services_categories_details_model.dart';
import '../../../data/models/public_models/public_properties_service/public_services_categories_model.dart';

class PublicGetServicesController extends GetxController {
  var getServicesCatg = PublicGetServiceCategoriesModel().obs;
  var getServiceDetails = PublicGetServiceDetailsModel().obs;
  var loadingData = true.obs;
  RxString error = "".obs;
  var loadingDetails = true.obs;
  RxString errorDetails = "".obs;
  int length = 0;
  int lengthDetails = 0;

  @override
  void onInit() {
    getServiceCategories();
    super.onInit();
  }

  Future<void> getServiceCategories() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      loadingData.value = true;
      var result = await PublicRepositoryDrop2.getServiceCategories();
      print(result);
      loadingData.value = false;
      if (result is PublicGetServiceCategoriesModel) {
        getServicesCatg.value = result;
        length = getServicesCatg.value.serviceCategories!.length;
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

  Future<void> getServiceCategoriesDetails(int categoryId) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      loadingDetails.value = true;
      var result =
          await PublicRepositoryDrop2.getServiceCategoriesDetails(categoryId);
      print(result);
      loadingDetails.value = false;
      if (result is PublicGetServiceDetailsModel) {
        getServiceDetails.value = result;
        lengthDetails = getServiceDetails.value.services!.length;

        loadingDetails.value = false;
      } else {
        errorDetails.value = result;
        loadingDetails.value = false;
      }
    } catch (e) {
      print("This is the error from controller $e");
      loadingDetails.value = false;
    }
  }
}
