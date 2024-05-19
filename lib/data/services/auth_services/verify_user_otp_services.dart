import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/verify_user_otp_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';

import 'package:http/http.dart' as http;

class VerifyUserOtpServices {
  static Future<dynamic> getData(
      String otpCode, String otpCodeForVerifyOTP) async {
    var data = {
      "mobile": SessionController().getPhone(),
      "otp": otpCode,
      "otpCode": otpCodeForVerifyOTP == null ? otpCode : otpCodeForVerifyOTP
    };
    var url = AppConfig().verifyUserOtp;
    var response = await BaseClientClass.postwithheader(url, data,
        token: SessionController().getLoginToken());
    print('Verify User Model log $response');
    if (response is http.Response) {
      VerifyUserOtpModel model = verifyUserOtpModelFromJson(response.body);
      return model;
    }

    return response;
  }

  static Future<dynamic> getDataFB(
      String otpCode, String otpCodeForVerifyOTP, bool status) async {
    var data = {
      "Mobile": SessionController().getPhone(),
      "OTP": otpCode,
      "otpCode": otpCodeForVerifyOTP,
      "OTPStatus": status
    };
    print('Data :::::getDataFB $data');
    var url = AppConfig().verifyUserOtpFB;
    print('url :::::getDataFB $url');
    var response = await BaseClientClass.postwithheader(url, data,
        token: SessionController().getLoginToken());
    print('Response ::::::');
    print('Verify User Model log $response');
    if (response is http.Response) {
      VerifyUserOtpModel model = verifyUserOtpModelFromJson(response.body);
      return model;
    }

    return response;
  }
}
