import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class LegalSettlementReqService {
  static Future<dynamic> submitReq(int contractId, String desc) async {
    var url = AppConfig().legalSettlementReq;

    var response = await BaseClientClass.post(
        url ?? "", {'contractId': contractId, 'description': desc});
    if (response is http.Response) {
      try {
        Map<String, dynamic> _jsonResp = json.decode(response.body);
        if (_jsonResp['status'] == 'Ok')
          return _jsonResp['addServiceRequest']['caseNo'];
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
