import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/public_models/get_city_model.dart';
import '../../helpers/session_controller.dart';

class GetCityServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getEmirates;

    var data;

    var response = await BaseClientClass.post(url, data,
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      GetEmirateModel getModel = getEmirateModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
