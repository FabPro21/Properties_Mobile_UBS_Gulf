import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_faqs/tenant_faqs_model.dart';
import "package:http/http.dart" as http;

class TenantFaqsSerice {
  static Future<dynamic> getFaqsCatg() async {
    var url = AppConfig().getTenantFaqsCatg;

    var response = await BaseClientClass.post(url ?? "", {});

    if (response is http.Response) {
      TenantFaqsModel getModel = tenantFaqsModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
