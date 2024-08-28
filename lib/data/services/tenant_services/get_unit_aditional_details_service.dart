import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/get_unit_aditional_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetUnitAditionalDetailsService {
  static Future<dynamic> getData() async {
    Map data = {"UnitId": SessionController().getContractUnitID().toString()};
    print('Data :::: getUnitAditionalDetailsModelFromJson::: $data');
    var response =
        await BaseClientClass.post(AppConfig().getUnitAditionalDetails??"", data);
    if (response is http.Response) {
      GetUnitAditionalDetailsModel getContractsModel =
          getUnitAditionalDetailsModelFromJson(response.body);
      return getContractsModel;
    }
    return response;
  }
}
