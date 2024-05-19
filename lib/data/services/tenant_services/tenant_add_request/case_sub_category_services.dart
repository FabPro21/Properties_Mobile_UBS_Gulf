import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_add_request/case_sub_category_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class CaseSubCategoryServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().caseSubCategory ;
    

    var data={"CategoryId":SessionController().getCaseCategoryId().toString()};

    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      CaseSubCategoryModel getModel =
          caseSubCategoryModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
