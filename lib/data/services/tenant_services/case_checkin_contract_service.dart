import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class CaseCheckinContractService {
  static Future<dynamic> checkinContract(
      int contractId, int caseNo, int dueActionId) async {
    var url = AppConfig().caseCheckinContract;

    var response = await BaseClientClass.post(url, {
      'ContractId': contractId.toString(),
      'CaseNo': caseNo.toString(),
      'ActionDueId': dueActionId.toString()
    });
    if (response is http.Response) {
      try {
        Map<String, dynamic> _jsonResp = json.decode(response.body);
        if (_jsonResp['status'] == 'Ok')
          return _jsonResp['status'];
        else
          return _jsonResp['message'];
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
