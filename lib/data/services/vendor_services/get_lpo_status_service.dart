import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_status_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetLpoStatusService {
  static Future<dynamic> getData() async {
    var url = AppConfig().getlpostatus;
    var response = await BaseClientClass.post(url, '');
    if (response is http.Response) {
      try {
        GetLpoStatusModel lpoStatusModel =
            getLpoStatusModelFromJson(response.body);
        return lpoStatusModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
