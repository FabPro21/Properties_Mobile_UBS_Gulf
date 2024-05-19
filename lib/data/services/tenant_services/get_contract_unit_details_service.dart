import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/get_contract_unit_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetContractUnitDetailsServices {
  static Future<dynamic> getData() async {
     Map data ={"UnitId":  SessionController().getContractUnitID().toString()};
    var response = await BaseClientClass.post(
        AppConfig().getContractUnitDetails ,
         data
        );
    if (response is http.Response) {
      GetContractUnitDetailsModel getContractsModel =
          getContractUnitDetailsModelFromJson(response.body);
      return getContractsModel;
    }
    return response;
  }
}
