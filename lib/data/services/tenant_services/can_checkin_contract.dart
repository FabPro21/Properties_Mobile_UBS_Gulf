import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../models/tenant_models/contract_requests/can_checkin.dart';

class CanCheckinContractService {
  static Future<dynamic> getData(int contractId) async {
    Map data = {"ContractId": contractId.toString()};
    var response =
        await BaseClientClass.post(AppConfig().getCanCheckinContract??"", data);
    if (response is http.Response) {
      return canCheckinModelFromJson(response.body);
    }
    return response;
  }
}
