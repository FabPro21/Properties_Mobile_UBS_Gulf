import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_financial_terms_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetContractFinancialTermsServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getContractFinancialTerms;
    var contractId = SessionController().getContractID().toString();
   

    Map data={
      "ContractId":contractId,
      "pageNo":1.toString(),
      "pageSize":100.toString(),
    };

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      GetContractFinancialTermsModel getAllLpoModel =
          getContractFinancialTermsModelFromJson(response.body);
      return getAllLpoModel;
    }
    return response;
  }
}
