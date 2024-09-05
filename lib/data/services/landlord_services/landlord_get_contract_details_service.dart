import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/landlord_models/contract_payable/contract_payable_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';

import '../../helpers/base_client.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../models/landlord_models/landlord_contract_details_model.dart';

class LandlordGetContractDetailsServices {
  static Future<dynamic> getContractDetails(int contractId) async {
    var data = {"ContractId": contractId.toString()};
    var response = await BaseClientClass.post(
        AppConfig().getLandlordContractDetails??"", data);
    try {
      if (response is Response) {
        return landlordContractDetailsModelFromJson(response.body);
      } else
        return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().someThingWentWrong;
    }
  }

  static Future<dynamic> getContractPayable(int contractId) async {
    var url = AppConfig().getLandlordContractPayable;
    var data = {"ContractId": SessionController().getContractID().toString()};
    print(
        'ContractId :::::: getContractPayable from GetContractsDetailsController $data');
    var resp = await BaseClientClass.post(url ?? "", data);

    if (resp is http.Response) {
      try {
        var model = landLordContractPayableModelFromJson(resp.body);
        return model;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return resp;
  }
}
