import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';

class GetPolicyDataService {
  static Future<dynamic> getPolicyData(String dataType) async {
    var data = {"Key": dataType};
    var resp = await BaseClientClass.post(AppConfig().getPolicyData??"", data);
    if (resp is http.Response) {
      return json.decode(resp.body);
    }
    return resp;
  }
}
