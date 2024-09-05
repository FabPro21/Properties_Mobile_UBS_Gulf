import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_contract_prop_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/meta_labels.dart';

class VendorGetContractPropsSvc {
  static Future<dynamic> getData() async {
    var completeUrl = AppConfig().getVendorContractProperties;
    var contractID = SessionController().getContractID().toString();
    Map data = {"ContractId": contractID};

    var response = await BaseClientClass.post(completeUrl??"", data);

    if (response is http.Response) {
      try {
        return vendorGetContractPropModelFromJson(response.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    } else
      return response;
  }
}
