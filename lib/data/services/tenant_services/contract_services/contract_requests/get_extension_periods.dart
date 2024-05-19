import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/contract_requests/get_extension_period_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class GetExtensionPeriodsService {
  static Future<dynamic> getData(int contractId) async {
    var url = AppConfig().getExtensionPeriods;
var data = {"ContractId":contractId.toString()};
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        return getExtensionPeriodModelFromJson(response.body);
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
