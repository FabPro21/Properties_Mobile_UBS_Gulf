import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class RenewContractService {
  static Future<dynamic> renewContract(
      int contractId, String startDate, String endDate, int dueActionid) async {
    var url = AppConfig().renewContract;

    var response = await BaseClientClass.post(url ?? "", {
      'contractId': contractId,
      'duration': '12 Month',
      'startDate': startDate,
      'endDate': endDate,
      'dueActionid': dueActionid
    });
    if (response is http.Response) {
      try {
        Map<String, dynamic> jsonResp = json.decode(response.body);
        if (jsonResp['status'] == 'Ok') {
          return jsonResp['addServiceRequest']['caseNo'];
        } else {
          return jsonResp['message'];
        }
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
