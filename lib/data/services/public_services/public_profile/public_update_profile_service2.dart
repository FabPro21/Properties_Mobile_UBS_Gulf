import 'dart:convert';

import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';

import '../../../helpers/session_controller.dart';

class PublicUpdateProfileService2 {
  static Future<dynamic> updateProfile(
    String name,
    String email,
  ) async {
    var url = AppConfig().publicUpdateProfile2;

    var data = {"Name": name, "Email": email, "UserId": 0};

    var resp = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());
    if (resp is http.Response) {
      try {
        final jsonResp = json.decode(resp.body);
        if (jsonResp["status"] == 'Ok')
          return 'Ok';
        else
          return jsonResp["message"];
      } catch (e) {
        return AppMetaLabels().anyError;
      }
    } else {
      return resp;
    }
  }
}
