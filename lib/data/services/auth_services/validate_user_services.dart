import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/validate_user_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class ValidateUserServices {
  static Future<dynamic> getData() async {
    var data = {
      "mobile": SessionController().getPhone(),
    };
    var url = AppConfig().validateUser;
    print(url);
    var response = await BaseClientClass.postwithheader(url, data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      ValidateUserModel model = validateUserModelFromJson(response.body);
      return model;
    }
    return response;
  }

  static Future<dynamic> getDataFB() async {
    var data = {
      "mobile": SessionController().getPhone(),
    };
    var url = AppConfig().validateUserFB;
    print(url);
    var response = await BaseClientClass.postwithheader(url, data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      ValidateUserModel model = validateUserModelFromJson(response.body);
      return model;
    }
    return response;
  }
}
