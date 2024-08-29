import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/auth_models/country_picker_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../helpers/session_controller.dart';

class CountryPickerServices {
  static Future<dynamic> getData() async {
    final String url = AppConfig().getcountries??"";
    Map data = {
      //'SecretKey':dotenv.env['secretKey'],
    };
    var response = await BaseClientClass.postwithheader(url, data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      CountryPickerModel countryPickerModel =
          countryPickerModelFromJson(response.body);
      return countryPickerModel;
    }
    return response;
  }
}
