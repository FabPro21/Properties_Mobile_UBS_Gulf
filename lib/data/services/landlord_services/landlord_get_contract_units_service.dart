import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';

import '../../helpers/base_client.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

import '../../models/landlord_models/landlord_contract_units_model.dart';

class LandlordGetContractUnitsServices {
  static Future<dynamic> getContractUnits(int contractId) async {
    var data = {"ContractId": contractId.toString()};
    var response =
        await BaseClientClass.post(AppConfig().getLandlordContractUnits??"", data);
    try {
      if (response is Response) {
        return landlordContractUnitsModelFromJson(response.body);
      } else
        return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().someThingWentWrong;
    }
  }
}
