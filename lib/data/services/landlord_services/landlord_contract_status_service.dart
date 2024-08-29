import 'dart:developer';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_contract_stauts_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetLandLordContractsStatusService {
  static Future<dynamic> getContractStatus() async {
    var url = AppConfig().getLandlordContractStatus;
    Map? data;
    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      try {
        log(response.body);
        GetContractLandLordStatusModel contractStatusModel =
            getContractStatusModelFromJson(response.body);
        return contractStatusModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
