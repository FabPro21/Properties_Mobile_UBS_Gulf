import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TerminateContractService {
  static Future<dynamic> terminateContract(int contractId, int vacatingId,
      String date, String desc, int dueActionid) async {
    var url = AppConfig().terminateContract;
    if (date == '') {
      var now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String foramteDate = formatter.format(now);
      date = foramteDate;
    }
    var data = {
      'VacatingId': vacatingId.toString(),
      'ContractId': contractId.toString(),
      'DueActionId': dueActionid.toString(),
      'Description': desc,
      'Duration': '',
      'StartDate': '',
      'EndDate': '',
      'VacatingDate': date,
    };
    var response = await BaseClientClass.post(url ?? "", data);
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
