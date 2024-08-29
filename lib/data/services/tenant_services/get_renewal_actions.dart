import 'dart:convert';
import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/contract_with_due_action.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetRenewalActions {
  static Future<dynamic> getData() async {
    var response =
        await BaseClientClass.post(AppConfig().contractRenewalActions??"", {});
    if (response is http.Response) {
      log(response.body);
      try {
        final _jsonResp = json.decode(response.body);
        if (_jsonResp['statusCode'] == '200') {
          return List<ContractWithDueAction>.from(_jsonResp["record"]
              .map((x) => ContractWithDueAction.fromJson(x)));
        } else if (_jsonResp['statusCode'] == '404') {
          return AppMetaLabels().noContractsFound;
        } else
          return _jsonResp['message'];
      } catch (e) {
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
class GetNewActions {
  static Future<dynamic> getData() async {
    var response =
        await BaseClientClass.post(AppConfig().contractNewActions??"", {});
    if (response is http.Response) {
      log(response.body);
      try {
        final _jsonResp = json.decode(response.body);
        if (_jsonResp['statusCode'] == '200') {
          return List<ContractWithDueAction>.from(_jsonResp["record"]
              .map((x) => ContractWithDueAction.fromJson(x)));
        } else if (_jsonResp['statusCode'] == '404') {
          return AppMetaLabels().noContractsFound;
        } else
          return _jsonResp['message'];
      } catch (e) {
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
