import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/contract_requests/contract_renewal_info.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class GetRenewalInfoService {
  static Future<dynamic> getData(int contractId) async {
    var url = AppConfig().getContractRenewalInfo;
var data = {"ContractId":contractId.toString()};
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        return contractRenewalInfoFromJson(response.body);
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
