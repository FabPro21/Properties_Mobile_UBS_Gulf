import 'package:fap_properties/data/models/tenant_models/contract_payable/register_payment_response.dart';
import 'package:fap_properties/data/models/tenant_models/contract_payable/tenant_register_payment_model.dart';
import 'package:http/http.dart' as http;
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';

class TenantRegisterPaymentService {
  static Future<dynamic> registerPayment(
      TenantRegisterPaymentModel data) async {
    var url = AppConfig().registerPayment;
    var resp = await BaseClientClass.post(url, data.toJson());
    print('Resposne Repo ::::::::: $resp');
    if (resp is http.Response) {
      var model = registerPaymentResponseFromJson(resp.body);
      return model;
    }
    return resp;
  }
}
class TenantRegisterPaymentServiceNew {
  static Future<dynamic> registerPaymentNew(
      TenantRegisterPaymentModel data) async {
    var url = AppConfig().registerPaymentNew;
    var resp = await BaseClientClass.post(url, data.toJson());
    
    if (resp is http.Response) {
      var model = registerPaymentResponseFromJson(resp.body);
      return model;
    }
    return resp;
  }
}
