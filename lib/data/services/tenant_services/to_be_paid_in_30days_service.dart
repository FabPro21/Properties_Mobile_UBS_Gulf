import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/to_be_paid_in_30days_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class ToBePaidIn30DaysService {
  static Future<dynamic> getData() async {
    var url = AppConfig().toBePaidIn30Days;
    var response = await BaseClientClass.post(url, '');
    if (response is http.Response) {
      try {
        return toBePaidIn30DaysModelFromJson(response.body);
      } catch (e) {
        return 'Error parsing json to model';
      }
    }
    return response;
  }
}
