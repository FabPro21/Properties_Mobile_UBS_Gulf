import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_dashboard_get_data_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../../../utils/constants/meta_labels.dart';

class TenantDashboardGetDataServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().tenantDashboardGetData;

    Map data;

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        TenantDashboardGetDataModel data =
            tenantDashboardGetDataModelFromJson(response.body);
        return data;
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
