import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/get_docs_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class TenantGetDocsByType {
  static Future<dynamic> getDocs(int caseNo, int roleId, int code) async {
    final String url =
        AppConfig().tenantGetDocsByType??"";
        var data = {"CaseNo":caseNo.toString(),"RoleId":roleId.toString(),"Code":code.toString()};
    var response = await BaseClientClass.post(url, data);
    print(response.body);
    if (response is http.Response) {
      try {
        return getDocsModelFromJson(response.body);
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    } else
      return response;
      // return response;
  }
}
