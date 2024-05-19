import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_location/public_location_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicLocationServices {
  static Future<dynamic> getLocation() async {
    var url = AppConfig().getPublicLocation;
    var data;
    var response = await BaseClientClass.post(url, data,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      PublicLocationModel getModel = publicLocationModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
