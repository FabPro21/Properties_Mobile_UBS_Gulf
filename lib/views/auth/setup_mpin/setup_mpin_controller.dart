import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/auth_models/add_mpin_model.dart';
import 'package:fap_properties/data/repository/auth_repository.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../common/no_internet_screen.dart';

class SetupMpinController extends GetxController {
  var loadingData = false.obs;
  RxBool fingerprintValue = false.obs;
  RxString enterMpinController = "".obs;
  RxString reEnterMpinController = "".obs;
  RxBool isUpdating = false.obs;
  RxBool mpinLength = true.obs;
  RxBool mpinMatch = true.obs;
  RxBool difficulty = true.obs;
  bool setupMpin = false;
  RxString name = "".obs;
  RxString mobileNumber = "".obs;
  RxString error = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> saveMpinBtn() async {
    error.value = '';
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    if (enterMpinController.value.length != 6 ||
        reEnterMpinController.value.length != 6) {
      mpinLength.value = false;
      error.value = AppMetaLabels().mpinNotLess;
    } else if (enterMpinController.value != reEnterMpinController.value) {
      mpinMatch.value = false;
      error.value = AppMetaLabels().mpinDidNotMatch;
    } else if (enterMpinController.value.length == 6 &&
        reEnterMpinController.value.length == 6 &&
        enterMpinController.value == reEnterMpinController.value) {
      if (isDifficult()) {
        mpinLength.value = true;
        mpinMatch.value = true;
        difficulty.value = true;
        isUpdating.value = true;
        GlobalPreferences.setbool(GlobalPreferencesLabels.fingerPrint,
            fingerprintValue.value ?? false);
        var response =
            await CommonRepository.addMpin(enterMpinController.value);
        if (response is AddMpinModel) {
          mpinLength.value = true;
          mpinMatch.value = true;
          FocusScope.of(Get.context).unfocus();
          Get.to(() => SelectRoleScreen());

          isUpdating.value = false;
        } else {
          error.value = response;
          isUpdating.value = false;
        }
      } else {
        difficulty.value = false;
        error.value = AppMetaLabels().easyMpin;
      }
    }
  }

  bool isDifficult() {
    var pin = enterMpinController.value.split('');
    for (int i = 1; i < pin.length - 1; i++) {
      if (pin[i - 1] == pin[i] && pin[i] == pin[i + 1]) {
        return false;
      } else if (int.parse(pin[i - 1]) + 1 == int.parse(pin[i]) &&
          int.parse(pin[i + 1]) - 1 == int.parse(pin[i]))
        return false;
      else if (int.parse(pin[i + 1]) + 1 == int.parse(pin[i]) &&
          int.parse(pin[i - 1]) - 1 == int.parse(pin[i])) return false;
    }
    return true;
  }
}
