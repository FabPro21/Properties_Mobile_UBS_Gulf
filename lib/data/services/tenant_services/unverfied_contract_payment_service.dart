import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/unverified_contract_payments.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class UnverfiedContractPaymentServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().unVerfiedContractPayment;
    var contractId = SessionController().getContractID();
    Map data = {"ContractId": contractId.toString()};
    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      try {
        return unverifiedContractPaymentsFromJson(response.body);
      } catch (e) {
         print(e);
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
