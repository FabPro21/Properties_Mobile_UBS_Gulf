import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class CancelTenantServiceRequest {
  static Future<String> cancelServiceRequest(var caseNo) async {
    var resp = await BaseClientClass.post(
        AppConfig().cancelServiceRequest, {"CaseNo":caseNo.toString()});
    if (resp is http.Response) {
      try {
        var jsonResp = jsonDecode(resp.body);
        if (jsonResp['status'] == 'Ok') return 'ok';
      } catch (e) {
        return 'Failed to cancel request';
      }
    }
    return resp;
  }
}
