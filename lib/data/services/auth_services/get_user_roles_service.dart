import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/auth_models/get_user_roles_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

import '../../helpers/session_controller.dart';

class GetUserRolesService {
  static Future<dynamic> getData() async {
    final String url = AppConfig().getUserRoles;
    var response = await BaseClientClass.postwithheader(url, {},
        token: SessionController().getToken());
    if (response is http.Response) {
      Map<String, dynamic> _jsonResp = json.decode(response.body);
      try {
        if (_jsonResp["statustCode"] == '200') 
        return getUserRoleModelFromJson(response.body);
        else
          return _jsonResp["statustCode"];
      } catch (e) {
        print('*******************');
        print(e);
        print(e.toString());
        print('*******************');
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
