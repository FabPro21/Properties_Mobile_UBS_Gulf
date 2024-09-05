import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/contract_invoices_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class ContractInvoicesServices {
  static Future<dynamic> getData() async {
    var contractId = SessionController().getContractID().toString();
    var url = AppConfig().contractInvoices;
    Map data = {"ContractId": contractId.toString()};

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      ContractInvoicesModel contractModel =
          contractInvoicesModelFromJson(response.body);
      return contractModel;
    }
    return response;
  }
}
