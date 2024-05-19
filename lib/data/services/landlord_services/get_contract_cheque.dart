import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/contract_cheque_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetContractChequesServicesLandLord {
  static Future<dynamic> getData(String transId) async {
    var url = AppConfig().getLandlordContractCheques;
    Map data = {"TransactionID": transId.toString()};
    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      GetContractChequesModelLandlord getContractsModel =
          getContractChequesModelFromJson(response.body);
      return getContractsModel;
    }
    return response;
  }
}
