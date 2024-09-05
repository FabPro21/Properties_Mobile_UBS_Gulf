import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class CanEditProfile {
  static Future<dynamic> canEditProfile() async {
    var resp = await BaseClientClass.post(AppConfig().canEditProfile??"", {});
    if (resp is http.Response) {
      try {
        var jsonResp = jsonDecode(resp.body);
        return jsonResp['caseNo'];
      } catch (e) {
        return AppMetaLabels().anyError;
      }
    } else
      return resp;
  }
}
