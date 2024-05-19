import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/get_cities_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetCitiesServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getCities;

    var data;

    var response = await BaseClientClass.post(url, data);

    if (response is http.Response) {
      GetCitiesModel getModel = getCitiesModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
