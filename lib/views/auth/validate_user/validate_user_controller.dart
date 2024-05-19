import 'dart:io';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/validate_user_model.dart';
import 'package:fap_properties/data/repository/auth_repository.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/auth/validate_user/phone_no_field.dart';
import 'package:fap_properties/views/auth/verify_user_otp/verify_user_otp_screen.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:get/get.dart';
import 'package:http_proxy/http_proxy.dart';
import 'package:ssl_pinning_plugin/ssl_pinning_plugin.dart';
import '../../common/safe_device_check.dart';

class ValidateUserController extends GetxController {
  var model = ValidateUserModel().obs;
  RxBool isUpdating = false.obs;
  RxBool loadingData = false.obs;
  RxBool textFieldTap = false.obs;
  RxBool validNo = false.obs;
  String otpCode;
  RxInt resendCounter = 0.obs;
  RxString error = "".obs;
  RxBool checkRooted = false.obs;
  RxBool enableSSL = true.obs;
  // bool isRooted = false;
  bool isSecure = false;
  RxString checkMsg = "".obs;
  RxBool jailbroken = false.obs;
  RxBool developerMode = false.obs;

  // isUpdating is using for rooted,sslpining et
  // loadingData is using for loader
  // validNo if number length is less than 6
  Future<void> getOtpBtn() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      Get.to(() => NoInternetScreen());
    }
    isUpdating.value = true;
    loadingData.value = true;
    if (PhoneNoField.phoneController.text.length < 6) {
      validNo.value = true;
      isUpdating.value = false;
      loadingData.value = false;
    } else if (PhoneNoField.phoneController.text.length >= 6) {
      validNo.value = false;

      // making a complete mobile no after geting the Dailing Code
      final String phone = SessionController().getDialingCode() +
          PhoneNoField.phoneController.text;

      // after completion of mobile no save in prefernece and Session controller
      SessionController().setPhone(phone);
      GlobalPreferencesEncrypted.setString(
        GlobalPreferencesLabels.phoneNumber,
        phone,
      );

      // checking weather Enable Rooted Device is enable or not
      // checking weather SSl Pining is enable or not
      // checking weather developerMode or jailbroken value is true or not
      if (checkRooted.value) {
        await _rootCheck();
      }
      if (!enableSSL.value) {
        HttpProxy httpProxy = await HttpProxy.createHttpProxy();
        HttpOverrides.global = httpProxy;
      }
      if (checkRooted.value && (jailbroken.value || developerMode.value)) {
        Get.to(() => SafeDeviceCheck());
      } else
        onCodeSent();
    }
  }

  Future<void> _rootCheck() async {
    try {
      jailbroken.value = await FlutterJailbreakDetection.jailbroken;
      developerMode.value = await FlutterJailbreakDetection.developerMode;
    } catch (e) {
      isUpdating.value = false;
      loadingData.value = false;
      Get.to(() => SafeDeviceCheck());
    }
  }

  Future<bool> checkSSL() async {
    try {
      checkMsg.value = await SslPinningPlugin.check(
        serverURL: AppConfig().baseUrl,
        httpMethod: HttpMethod.Head,
        sha: SHA.SHA1,
        allowedSHAFingerprints: [
          // "84 c0 e2 bc b9 ae 9f de 00 27 b6 22 ee b1 cf 92 50 c6 82 0e", old certificate
          "53 C0 3F CE D7 18 86 B2 29 11 48 98 BD 90 6A AF 73 83 2D 08"
          // "9F A6 EF 8C 93 86 50 C9 4D 95 96 ED 2E 84 BF 21 F7 1E C3 AC"
        ],
        timeout: 60,
      );
      return true;
    } catch (e) {
      isUpdating.value = false;
      loadingData.value = false;
      return false;
    }
  }

  Future<void> onCodeSent() async {
    isUpdating.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      Get.to(() => NoInternetScreen());
    }
    error.value = '';
    try {
      loadingData.value = true;
      var result = await CommonRepository.validateUser();
      loadingData.value = false;
      if (result is ValidateUserModel) {
        model.value = result;
        FocusScope.of(Get.context).unfocus();
        PhoneNoField.phoneController.clear();
        Get.to(() => VerifyUserOtpScreen(
              otpCodeForVerifyOTP: model.value.otpCode,
            ));
        SessionController().setOtpCode(result.otpCode);
      } else {
        error.value = AppMetaLabels().noDatafound;
      }
    } catch (e) {
      loadingData.value = false;
      isUpdating.value = false;
    }
    loadingData.value = false;
    isUpdating.value = false;
  }
}
