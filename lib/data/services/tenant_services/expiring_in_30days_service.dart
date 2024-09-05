import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/expiring_in_30days.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class ExpiringIn30DaysService {
  static Future<dynamic> getData() async {
    var url = AppConfig().contractsExpiringIn30Days;

    var response = await BaseClientClass.post(url ?? "", '');
    if (response is http.Response) {
      try {
        return contractExpire30DaysFromJson(response.body);
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
