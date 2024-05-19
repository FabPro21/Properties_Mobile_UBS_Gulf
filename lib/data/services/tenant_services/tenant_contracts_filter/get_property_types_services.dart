import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/get_property_types_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetPropertyTypesService {
  static Future<dynamic> getData() async {
    var url = AppConfig().getPropTypes;
    var response = await BaseClientClass.post(url, '');
    if (response is http.Response) {
      try {
        GetPropertyTypesModel propertyTypesModel =
            getPropertyTypesModelFromJson(response.body);
        return propertyTypesModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
