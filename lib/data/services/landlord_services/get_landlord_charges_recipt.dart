import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/contract_charge_receipts_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/meta_labels.dart';

class LandlordCChargeReceiptsService {
  static Future<dynamic> getData(int chargesTypeId) async {
    var url = AppConfig().contractChargeReceiptsLandlord;
    Map data = {
      'ContractId': SessionController().getContractID().toString(),
      'ChargesTypeID': chargesTypeId.toString()
    };
    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      try {
        return contractChargeReceiptsModelFromJson(response.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
