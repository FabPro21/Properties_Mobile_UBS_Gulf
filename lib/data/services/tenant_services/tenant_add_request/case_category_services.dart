import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_add_request/case_category_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class CaseCategoryServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().caseCategory;

    var data;

    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      CaseCategoryModel getModel = caseCategoryModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
