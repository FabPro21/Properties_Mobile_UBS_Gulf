import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/contract_payment_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class ContractPaymentsServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getContractPayments;
    Map data = {"ContractId": SessionController().getContractID().toString()};

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      ContractPaymentModel paymentsModel =
          contractPaymentModelFromJson(response.body);
      return paymentsModel;
    }
    return response;
  }
}
