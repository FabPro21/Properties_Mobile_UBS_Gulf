import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetContractsDetailsServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getContractDetails;
    
    var contractID = SessionController().getContractID();
    Map data = {"ContractId": contractID.toString()};
    
    print('Contracts/GetContractDetails ::::::  $data');
    
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      log(response.body);
      try {
        GetContractDetailsModel getContractDetailsModel =
            getContractDetailsModelFromJson(response.body);
        return getContractDetailsModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
