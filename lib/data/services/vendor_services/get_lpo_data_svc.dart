import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_data_response.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart';

class GetLpoDataSvc {
  static Future<dynamic> getData() async {
    var response = await BaseClientClass.post(AppConfig().getlpos, {});
    if (response is Response) {
      try {
        return GetLpoDataResponse.fromRawJson(response.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    } else
      return response;
  }
}
