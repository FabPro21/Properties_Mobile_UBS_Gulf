import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/auth_models/update_user_language_model.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

import '../../data/repository/auth_repository.dart';

class UpdateUserLanguageController extends GetxController {
  var model = UpdateUserLanguageModel().obs;

  var loadingData = false.obs;
  RxString error = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> updateData(langId) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    loadingData.value = true;
    var result = await CommonRepository.updateLanguage(langId);
    loadingData.value = false;
    if (result is UpdateUserLanguageModel) {
      model.value = result;
      update();
    } else {
      error.value = result;
    }
  }
}
