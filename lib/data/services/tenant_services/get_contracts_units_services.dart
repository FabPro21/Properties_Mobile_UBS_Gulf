import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/get_contract_units_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetContractsUnitsServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getContractUnits;
    var contractId = SessionController().getContractID();
    Map data = {
      "ContractId":contractId.toString()
    };
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      GetContractUnitsModel getContractsModel =
          getContractUnitsModelFromJson(response.body);
      return getContractsModel;
    }
    return response;
  }
}
