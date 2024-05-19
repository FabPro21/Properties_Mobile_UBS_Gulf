import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_details_response.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart';

class VendorGetLpoDetailsSvc {
  static Future<dynamic> getData(String lpoId) async {
    Map data = {"LpoId": lpoId.toString()};
    var response = await BaseClientClass.post(AppConfig().getlposdetail, data);
    if (response is Response) {
      try {
        return GetLpoDetailsResponse.fromRawJson(response.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    } else
      return response;
  }
}
