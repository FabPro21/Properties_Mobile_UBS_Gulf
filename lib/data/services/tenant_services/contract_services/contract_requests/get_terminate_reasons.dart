import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/contract_requests/vacating_reasons.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class GetTerminateReasonsService {
  static Future<dynamic> getData() async {
    var response =
        await BaseClientClass.post(AppConfig().getTerminateReasons??"", {});
    if (response is http.Response) {
      try {
        return vacatingReasonsFromJson(response.body);
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
