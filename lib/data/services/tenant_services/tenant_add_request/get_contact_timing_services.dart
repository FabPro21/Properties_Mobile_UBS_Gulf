import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_add_request/get_contact_timing_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetContactTimingServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getContactTiming;

    var data;

    var response = await BaseClientClass.post(url ?? "", data);

    if (response is http.Response) {
      GetContactTimingModel getModel =
          getContactTimingModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
