import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_add_request/save_services_request_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class SaveServiceRequestServices {
  static Future<dynamic> getData(catId, subCatId, contractUnitId, desc,
      contactName, contactMobile, contactTimeId) async {
    var url = AppConfig().saveServiceRequest;
    var data = {
      "CaseCategoryId": catId.toString(),
      "CaseSubCategoryId": subCatId.toString(),
      "ContractUnitId": contractUnitId.toString(),
      "Description": desc,
      "OtherContactPersonName": contactName,
      "OtherContactPersonMobile": contactMobile,
      "contactTimeId": contactTimeId == null ? '0' : contactTimeId.toString()
    };
    // var data = {
    //   "CaseCategoryId": catId.toString(),
    //   "CaseSubCategoryId": subCatId.toString(),
    //   "ContractUnitId": contractUnitId.toString(),
    //   "Description": desc,
    //   "OtherContactPersonName": contactName,
    //   "OtherContactPersonMobile": contactMobile,
    //   "contactTimeId": contactTimeId == null ? '0' : contactTimeId.toString()
    // };
    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      SaveServiceRequestModel getModel =
          saveServiceRequestModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
