import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../models/tenant_models/tenant_add_request/get_case_types_model.dart';

class GetCaseTypesServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getCaseTypes;

    var data;

    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      GetCaseTypesModel getModel = getCaseTypesModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
