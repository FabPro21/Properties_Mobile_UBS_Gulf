import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_properties_response.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart';

class GetLpoPropertiesSvc {
  static Future<dynamic> getData() async {
    var response = await BaseClientClass.post(AppConfig().getlpoproperties??"", {});
    if (response is Response) {
      try {
        return GetLpoPropertiesResponse.fromRawJson(response.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    } else
      return response;
  }
}
