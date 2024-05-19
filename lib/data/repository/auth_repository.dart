import 'package:fap_properties/data/services/auth_services/add_mpin_services.dart';
import 'package:fap_properties/data/services/auth_services/compare_dev_token_service.dart';
import 'package:fap_properties/data/services/auth_services/country_picker_services.dart';
import 'package:fap_properties/data/services/auth_services/get_user_roles_service.dart';
import 'package:fap_properties/data/services/auth_services/update_device_info_services.dart';
import 'package:fap_properties/data/services/auth_services/validate_public_role_service.dart';
import 'package:fap_properties/data/services/auth_services/validate_role_by_fp_service.dart';
import 'package:fap_properties/data/services/auth_services/validate_role_by_mpin_service.dart';
import 'package:fap_properties/data/services/auth_services/validate_user_services.dart';
import 'package:fap_properties/data/services/auth_services/verify_user_otp_services.dart';

import '../services/auth_services/update_user_language_services.dart';
import '../services/tenant_services/service_requests/get_languages_services.dart';

class CommonRepository {
  static Future<dynamic> countryPicker() => CountryPickerServices.getData();
  static Future<dynamic> validateUser() => ValidateUserServices.getData();
  static Future<dynamic> validateUserFB() => ValidateUserServices.getDataFB();
  static Future<dynamic> verifyOtp(
          String otpCode, String otpCodeForVerifyOTP) =>
      VerifyUserOtpServices.getData(otpCode, otpCodeForVerifyOTP);
  static Future<dynamic> verifyOtpFB(
          String otpCode, String otpCodeForVerifyOTP, bool status) =>
      VerifyUserOtpServices.getDataFB(otpCode, otpCodeForVerifyOTP, status);
  static Future<dynamic> updateDeviceInfo(
          String deviceName, String deviceTokken, String deviceType) =>
      UpdateDeviceInfoService.getData(deviceName, deviceTokken, deviceType);
  static Future<dynamic> addMpin(String mpin) => AddMpinServices.getData(mpin);
  static Future<dynamic> getUserRoles() => GetUserRolesService.getData();
  static Future<dynamic> validateRoleByMpin(String mpin) =>
      ValidateRoleByMpinService.getData(mpin);
  static Future<dynamic> validateRoleByFp() =>
      ValidateRoleByFPService.getData();
  static Future<dynamic> validatePublicRole() =>
      ValidatePublicRoleService.getData();
  static Future<dynamic> getLanguage() => GetLanguageServices.getData();
  static Future<dynamic> updateLanguage(langId) =>
      UpdateUserLanguageServices.getData(langId);
  static Future<dynamic> compareDevToken(String devToken, String num) =>
      CompareDevTokenService.getData(devToken, num);
}
