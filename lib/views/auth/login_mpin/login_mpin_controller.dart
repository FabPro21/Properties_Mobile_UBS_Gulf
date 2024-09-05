// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/session_token_model.dart';
import 'package:fap_properties/data/models/auth_models/validate_user_model.dart';
import 'package:fap_properties/data/repository/auth_repository.dart';
import 'package:fap_properties/utils/constants/app_const.dart';
import 'package:fap_properties/utils/constants/global_preferences.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/auth/blocked_device/blocked_device_screen.dart';
import 'package:fap_properties/views/auth/otp_firebase/otp_firebase_controller.dart';
import 'package:fap_properties/views/auth/verify_user_otp/verify_user_otp_screen.dart';
import 'package:fap_properties/views/landlord/landlord_home.dart';
import 'package:fap_properties/views/public_views/public_notifications/public_notifications.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_tabs/tenant_dashboard_tabs.dart';
import 'package:fap_properties/views/vendor/vendor_dashboard/vendor_dashboard_tabs/vendor_dashboard_tabs.dart';
import 'package:fap_properties/views/vendor/vendor_notifications/vendor_notifications.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '../../common/no_internet_screen.dart';
import '../../public_views/search_properties_dashboard_tabs/search_properties_dashboard_tabs.dart';
import '../../tenant/tenant_notifications/tenant_notifications.dart';

class LoginMpinController extends GetxController {
  RxBool sharedPersonalDataValue = true.obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  RxBool loadingData = false.obs;
  RxBool validMpin = true.obs;
  RxBool failed = false.obs;
  RxString currentText = "".obs;
  RxInt failedAattempts = 0.obs;
  RxBool isForgot = false.obs;
  String? otpCode;
  RxBool resettingMpin = false.obs;
  RxInt mpinAttemptsCounter = 0.obs;
  String userMpin = "";
  RxBool fingerprint = false.obs;

  // getPrefsData() async {
  //   fingerprint.value =
  //       await GlobalPreferences.getBool(GlobalPreferencesLabels.fingerPrint);
  //   if (fingerprint.value == true) {
  //     validateRoleByFP();
  //   }
  // }

  @override
  void onInit() {
    print(SessionController().getfingerprint());
    if (SessionController().getfingerprint() != null) {
      if (SessionController().getfingerprint()) {
        validateRoleByFP();
      }
    }
    // getPrefsData();
    super.onInit();
  }

  void validateRoleByMpin() async {
    if (currentText.value.length == 6) {
      loadingData.value = true;
      var resp = await CommonRepository.validateRoleByMpin(currentText.value);
      loadingData.value = false;
      mpinAttemptsCounter.value++;
      print(mpinAttemptsCounter.value++);

      if (mpinAttemptsCounter.value >= 7) {
        Get.offAll(() => BlockedDeviceScreen());
        GlobalPreferences.setInt(
            GlobalPreferencesLabels.blockTime, AppConst.blockTime);
        GlobalPreferences.setbool(GlobalPreferencesLabels.isBlocked, true);
      } else if (resp is SessionTokenModel) {
        if (SessionController().getSelectedRoleId() == 4)
          SessionController().setPublicToken(resp.token);
        else
          SessionController().setToken(resp.token);
        goToDashboard();
      } else {
        validMpin.value = false;
      }
    } else
      validMpin.value = false;
  }

  void validateRoleByFP() async {
    var resp;
    bool isAuthenticated = await _authenticateWithBiometrics();
    if (isAuthenticated) {
      loadingData.value = true;
      resp = await CommonRepository.validateRoleByFp();
      loadingData.value = false;
    }
    if (resp is SessionTokenModel) {
      if (SessionController().getSelectedRoleId() == 4)
        SessionController().setPublicToken(resp.token);
      else
        SessionController().setToken(resp.token);
      goToDashboard();
    } else {
      loadingData.value = false;
    }
  }

  Future<void> forgotBtn() async {
    resettingMpin.value = true;
    GlobalPreferences.setbool(GlobalPreferencesLabels.isLoginBool, false);

    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.offAll(NoInternetScreen());
    }
    SessionController().setResetMpin(true);
    var _resp = await CommonRepository.validateUser();
    resettingMpin.value = false;
    if (_resp is ValidateUserModel) {
      // Get.to(() => VerifyUserOtpScreen());
      print('OTP Code IS :::: +=====> ${_resp.otpCode}');
      Get.to(() => VerifyUserOtpScreen(
            otpCodeForVerifyOTP: _resp.otpCode??"",
          ));
      SessionController().setOtpCode(_resp.otpCode);
    } else {
      Get.snackbar(
        AppMetaLabels().error,
        _resp,
        backgroundColor: AppColors.white54,
      );
    }
  }

  FirebaseAuthController authController = Get.put(FirebaseAuthController());
  Future<void> forgotBtnFB() async {
    resettingMpin.value = true;
    GlobalPreferences.setbool(GlobalPreferencesLabels.isLoginBool, false);

    print('Firebase is  enable');
    final String phone = SessionController().getPhone()??"";
    print('Phone Validation ::: $phone');
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.offAll(NoInternetScreen());
    }
    SessionController().setResetMpin(true);
    await authController.forgotMPin();
    resettingMpin.value = false;
  }

  final LocalAuthentication auth = LocalAuthentication();
  Future<bool> _authenticateWithBiometrics() async {
    try {
      return await auth.authenticate(
          localizedReason: AppMetaLabels().pleaseUseFingerprint,
          options: AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: true, biometricOnly: true));

      // ignore: unused_catch_clause
    } on PlatformException catch (e) {
      Get.snackbar(
        AppMetaLabels().biometric,
        AppMetaLabels().authenticationfailed,
        backgroundColor: AppColors.white54,
      );
      return await _authenticate();
    }
  }

  void goToDashboard() {
    final notificationData = SessionController().getNotificationData();
    switch (SessionController().getSelectedRoleId()) {
      case 1:
        Get.offAll(
          () => TenantDashboardTabs(),
        );
        if (notificationData != null && notificationData['roleId'] == '1') {
          Get.to(() => TenantNotifications());
        }
        break;

      case 2:
        Get.offAll(
          () => LandlordHome(),
        );

        break;
      case 3:
        {
          print('User Type :::::: ${SessionController().vendorUserType}');
          Get.offAll(
            () => VendorDashboardTabs(),
          );
          if (notificationData != null && notificationData['roleId'] == '3') {
            Get.to(() => VendorNotification());
          }
        }
        break;
      case 4:
        Get.offAll(
          () => SearchPropertiesDashboardTabs(),
        );
        if (notificationData != null && notificationData['roleId'] == '4') {
          Get.to(() => PublicNotification());
        }

        break;
    }
    SessionController().setNotificationData({});
  }

  Future<bool> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          options:
              AuthenticationOptions(useErrorDialogs: true, stickyAuth: true));

      return authenticated;
      // ignore: unused_catch_clause
    } on PlatformException catch (e) {
      return authenticated;
    }
  }
}
