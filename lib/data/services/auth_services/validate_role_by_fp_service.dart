import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/session_token_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class ValidateRoleByFPService {
  static Future<dynamic> getData() async {
    var data = {
      "roleId": SessionController().getSelectedRoleId(),
      "userId": SessionController().getUserId(),

    };
    var url = AppConfig().validateRoleByFP;
    var response = await BaseClientClass.postwithheader(url, data,
        token: null);
    if (response is http.Response) {
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
