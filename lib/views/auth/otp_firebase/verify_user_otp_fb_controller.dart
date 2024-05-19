import 'dart:async';
import 'dart:io';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/session_token_model.dart';
import 'package:fap_properties/data/models/auth_models/update_device_info_model.dart';
import 'package:fap_properties/data/models/auth_models/validate_user_model.dart';
import 'package:fap_properties/data/models/auth_models/verify_user_otp_model.dart';
import 'package:fap_properties/data/repository/auth_repository.dart';
import 'package:fap_properties/utils/constants/app_const.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/auth/blocked_device/blocked_device_screen.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/auth/public_login/public_login_screen.dart';
import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
import 'package:fap_properties/views/auth/setup_mpin/setup_mpin.dart';
import 'package:fap_properties/views/public_views/search_properties_more/public_profile/update_public_profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyUserOtpControllerFB extends GetxController {
  var model = VerifyUserOtpModel().obs;
  var validateUserModel = ValidateUserModel().obs;
  RxBool validOTP = true.obs;
  RxBool hasError = false.obs;
  RxBool loadingData = false.obs;
  RxBool pinFieldTap = false.obs;
  Color changeColor;
  String userMpin;
  String phoneNo;
  String statusCode;
  String deviceName;
  String deviceToken;
  String deviceType;
  RxString error = "".obs;
  RxBool resending = false.obs;
  RxInt resendCounter = 0.obs;
  RxInt otpAttemptsCounter = 0.obs;

  @override
  void onInit() {
    _getDeviceTokken();
    _getDeviceDetails();
    otpAttemptsCounter.value = 0;
    resendCounter.value = 0;
    validOTP.value = true;
    super.onInit();
  }

  Future<void> verifyOtpBtn(
      String otp, String otpCodeForVerifyOTP, bool status) async {
    loadingData.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      Get.to(() => NoInternetScreen());
    }
    var result =
        await CommonRepository.verifyOtpFB(otp, otpCodeForVerifyOTP, status);
    if (result is VerifyUserOtpModel) {
      model.value = result;
      validOTP.value = true;
      changeColor = AppColors.whiteColor;

      // update public profile Start Logic from here
      User updatedUserModel;
      if (model.value.isNewUser == true) {
        updatedUserModel = await Get.to(() => UpdatePublicProfile(
              model: model.value,
            ));
        model.value.user = updatedUserModel;
      }

      // update public profile End Logic from here

      ////////////////////////////
      /// SessionController ///
      ////////////////////////////

      SessionController().setUser(model.value.user);
      SessionController().setLoginToken(model.value.token);
      SessionController().setToken(model.value.token);
      /////////////////////////////////////
      /// GlobalPreferencesEncrypted ///
      ////////////////////////////////////
      saveDataLocally();
      //////////////////////////////
      /// update device info ///
      //////////////////////////////
      bool _updatedDeviceInfo = await updateDeviceInfo();
      if (_updatedDeviceInfo) {
        if (model.value.user.mpinSet && !SessionController().getResetMpin())
          Get.offAll(() => SelectRoleScreen());
        else
          Get.offAll(() => SetupMpinScreen());
      }
    } else {
      validOTP.value = false;
      changeColor = AppColors.redColor;
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
      otpAttemptsCounter.value++;
      if (otpAttemptsCounter.value >= 5) {
        Get.offAll(() => BlockedDeviceScreen());
        GlobalPreferences.setInt(
            GlobalPreferencesLabels.blockTime, AppConst.blockTime);
        GlobalPreferences.setbool(GlobalPreferencesLabels.isBlocked, true);
      }
    }
    loadingData.value = false;
  }

  void saveDataLocally() async {
    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.loginToken,
      model.value.token ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userName,
      model.value.user.name ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userNameAr,
      model.value.user.fullNameAr ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userID,
      model.value.user.userId.toString(),
    );

    print(
        'User ID from Data svaed Locally ::: ${model.value.user.userId.toString()}');

    GlobalPreferences.setbool(
      GlobalPreferencesLabels.isLoginBool,
      true,
    );
  }

  Future<bool> updateDeviceInfo() async {
    var response = await CommonRepository.updateDeviceInfo(
        deviceName, deviceToken, deviceType);
    if (response is UpdateDeviceInfoModel) {
      return true;
    } else {
      error.value = response;
      return false;
    }
  }

  //////////////////////////////////////////
  /////   _getDeviceDetails
  //////////////////////////////////////////
  _getDeviceDetails() async {
    if (Platform.isAndroid) {
      deviceType = "Android";
      deviceName = "Android";
    } else if (Platform.isIOS) {
      deviceType = "IOS";
      deviceName = "IOS";
    }
  }
  //////////////////////////////////////////
  /////   getDeviceTokken
  //////////////////////////////////////////

  Future<void> _getDeviceTokken() async {
    FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then(
      (String token) {
        assert(token != null);
        deviceToken = token;
        SessionController().setDeviceTokken(deviceToken);
        GlobalPreferencesEncrypted.setString(
            GlobalPreferencesLabels.deviceToken, deviceToken);
      },
    );
  }

  void validatePublicRole() async {
    var resp;
    loadingData.value = true;
    resp = await CommonRepository.validatePublicRole();
    loadingData.value = false;
    if (resp is SessionTokenModel) {
      SessionController().setSelectedRoleId(4);
      SessionController().setPublicToken(resp.token);
      Get.offAll(() => PublicLoginScreen());
    } else {
      loadingData.value = false;
    }
  }
}
