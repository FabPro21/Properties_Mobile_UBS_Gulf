import 'dart:async';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/views/auth/otp_firebase/validate_user_fb.dart';
import 'package:fap_properties/views/auth/validate_user/validate_user_screen.dart';
import 'package:get/get.dart';

class BlockedDeviceController extends GetxController {
  @override
  void onInit() {
    getPrefsData();
    setTimer();
    super.onInit();
  }

  int blockTime = 0;
  bool isBlocked = false;
  RxString secText = "".obs;

  Future<void> getPrefsData() async {
    blockTime =
        await GlobalPreferences.getInt(GlobalPreferencesLabels.blockTime);
    isBlocked =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.isBlocked);
  }

  void setTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (blockTime >= 2) {
        blockTime = blockTime - 1;
        GlobalPreferences.setInt(GlobalPreferencesLabels.blockTime, blockTime);
        secText.value = blockTime.toString();
      } else {
        timer.cancel();
        Get.offAll(() => SessionController().enableFireBaseOTP
            ? ValidateUserScreenFB()
            : ValidateUserScreen());
        // : Get.offAll(() => ValidateUserArabicScreen());
        GlobalPreferencesEncrypted.clearValues();
        GlobalPreferences.setClear();
        GlobalPreferences.setbool(GlobalPreferencesLabels.isBlocked, false);
      }
      print(blockTime);
    });
  }
}
