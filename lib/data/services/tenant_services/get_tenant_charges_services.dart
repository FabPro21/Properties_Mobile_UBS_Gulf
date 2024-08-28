import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/get_contract_charges_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetContractsChargesServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getContractCharges;
    var contractId = SessionController().getContractID();
    Map data = {"ContractId": contractId.toString()};
    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      GetContractChargesModel getContractsModel =
          getContractChargesModelFromJson(response.body);
      return getContractsModel;
    }
    return response;
  }
}
