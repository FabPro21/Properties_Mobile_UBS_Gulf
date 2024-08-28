import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/contract_payment_cheque_models.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetContractChequesServices {
  static Future<dynamic> getData(String transId) async {
    var url = AppConfig().getContractCheques;
    Map data = {"TransactionID": transId.toString()};
    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      GetContractChequesModel getContractsModel =
          getContractChequesModelFromJson(response.body);
      return getContractsModel;
    }
    return response;
  }
}
