import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/update_user_language_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class UpdateUserLanguageServices {
  static Future<dynamic> getData(langId) async {
    var url = AppConfig().updateLanguage;

    var data = {
      // "SecretKey": dotenv.env['secretKey'],
      "Mobile": SessionController().getPhone(),
      "LangId": langId.toString(),
    };

    var response = await BaseClientClass.postwithheader(url??"", data,
        token: SessionController().getLoginToken());

    if (response is http.Response) {
      print('hello');
      UpdateUserLanguageModel getModel =
          updateUserLanguageModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
