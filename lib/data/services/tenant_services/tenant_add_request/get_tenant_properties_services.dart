import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_add_request/get_tenant_properties_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetTenantUnitsServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getTenantContractUnits;
    // passing Tenantid 0 because it is not using on the backend side 
    // sending '0' because  want to make success the if condition that is on the backened
    var data = {"Tenantid": '0'};
    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      GetTenantPropertiesModel getModel =
          getTenantPropertiesModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
