import 'package:fap_properties/data/models/tenant_models/tenant_profile/tenant_profile_update_model.dart';
import 'package:http/http.dart' as http;
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';

class TenantUpdateProfileService {
  static Future<dynamic> updateProfile(
      String name, String mobileNo, String email, String address) async {
    var url = AppConfig().updateTenantProfile;

    var data = {
      "caseNo": 0.toString(),
      "description": null,
      "personName": name,
      "personMobile": mobileNo,
      "personEmail": email,
      "address": address
    };

    var resp = await BaseClientClass.post(url ?? "", data);
    if (resp is http.Response) {
      return tenantUpdateProfileModelFromJson(resp.body);
    }
    return resp;
  }
}
