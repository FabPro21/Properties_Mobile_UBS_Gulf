import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/get_contracts_status_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetContractsStatusService {
  static Future<dynamic> getData() async {
    print(':::::::::::::+++++ Vendor +++++++::::::::::::::::::::');
    var url = AppConfig().getContractStatus;
    Map data;
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        GetContractStatusModel contractStatusModel =
            getContractStatusModelFromJson(response.body);
        return contractStatusModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
