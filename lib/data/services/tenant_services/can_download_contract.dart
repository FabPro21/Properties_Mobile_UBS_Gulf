import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/can_download_contract.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class CanDownloadContractService {
  static Future<dynamic> getData(int contractId) async {
    Map data = {"ContractId": contractId.toString()};
    var response =
        await BaseClientClass.post(AppConfig().canDownloadContract??"", data);
    if (response is http.Response) {
      return canDownloadContractFromJson(response.body);
    }
    return response;
  }
}
