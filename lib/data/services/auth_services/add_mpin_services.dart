import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/add_mpin_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class AddMpinServices {
  static Future<dynamic> getData(String? mpin) async {
    var data = {
      "mpin": mpin,
    };
    var url = AppConfig().saveMpin;
    var response = await BaseClientClass.postwithheader(url!, data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      AddMpinModel addMpinModel = addMpinModelFromJson(response.body);
      return addMpinModel;
    }
    return response;
  }
}
