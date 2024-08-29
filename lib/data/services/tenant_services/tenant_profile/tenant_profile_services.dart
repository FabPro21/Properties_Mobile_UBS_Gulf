import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_profile/tenant_profile_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class TenantProfileServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getTenantProfile;
    
    var response = await BaseClientClass.post(url ?? "", {});

    if (response is http.Response) {
      TenantProfileModel data = tenantProfileModelFromJson(response.body);
      return data;
    }
    return response;
  }
}
