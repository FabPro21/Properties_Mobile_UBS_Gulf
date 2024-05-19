import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';

import '../../helpers/base_client.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

import '../../models/landlord_models/landlord_contract_charges_model.dart';

class LandlordGetContractChargesServices {
  static Future<dynamic> getContractCharges(int contractId) async {
    var response = await BaseClientClass.post(
        AppConfig().getLandlordContractCharges, {'ContractId': contractId});
    try {
      if (response is Response) {
        return landlordContractChargesModelFromJson(response.body);
      } else
        return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().someThingWentWrong;
    }
  }
}
