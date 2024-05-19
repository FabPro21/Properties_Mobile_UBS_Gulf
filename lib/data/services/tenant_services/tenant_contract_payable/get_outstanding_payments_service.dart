import 'dart:developer';

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/contract_payable/outstanding_payments_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:flutter/foundation.dart';

class GetOutstandingPaymentsService {
  Future<dynamic> getOutstandingPayments(int contractId) async {
    var url = AppConfig().getOutstandingPayments;
    var data = {"ContractId": SessionController().getContractID().toString()};
    print( "ContractId:::::GetOutstandingPaymentsService::::::::::$data");
    var resp = await BaseClientClass.post(url, data);

    if (resp is http.Response) {
      if (kDebugMode) log(resp.body);
      try {
        return outstandingPaymentsModelFromJson(resp.body);
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return resp;
  }
}
class GetOutstandingPaymentsNewContractService {
  Future<dynamic> getOutstandingPaymentsNewContract(int contractId) async {
    var url = AppConfig().getOutstandingPaymentsNew;
    var data = {"ContractId": SessionController().getContractID().toString()};
    print( "ContractId:::::GetOutstandingPaymentsService::::::::::$data");
    var resp = await BaseClientClass.post(url, data);

    if (resp is http.Response) {
      if (kDebugMode) log(resp.body);
      try {
        return outstandingPaymentsModelFromJson(resp.body);
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return resp;
  }
}
