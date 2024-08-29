import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/auth_models/get_languages_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetLanguageServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getLanguage;
    print(url);
    var data = {
      //  "SecretKey": dotenv.env['secretKey'],
    };

    var response = await BaseClientClass.postwithheader(url??"", data);

    if (response is http.Response) {
      GetLanguagesModel getModel = getLanguagesModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
