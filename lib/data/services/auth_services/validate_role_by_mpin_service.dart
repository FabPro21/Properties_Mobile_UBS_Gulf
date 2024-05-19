import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/session_token_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class ValidateRoleByMpinService {
  static Future<dynamic> getData(String mpin) async {
    var data = {
      "MPIN": mpin,
      "RoleId": SessionController().getSelectedRoleId(),
      
    };
    // print('**************************');
    print(AppConfig().validateRoleByMpin);
    print(data);
    // print('**************************');
    var url = AppConfig().validateRoleByMpin;
    var response = await BaseClientClass.postwithheader(url, data,
        token: SessionController().getToken());
    if (response is http.Response) {
      print(response);
      Map<String, dynamic> _jsonResp = json.decode(response.body);
      if (_jsonResp["statusCode"] == '200') {
        try {
          return SessionTokenModel.fromJson(_jsonResp);
        } catch (e) {
          return AppMetaLabels().anyError;
        }
      } else {
        return _jsonResp["message"];
      }
    }
    return response;
  }
}
