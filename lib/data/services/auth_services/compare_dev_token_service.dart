import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/auth_models/compare_dev_token_resp.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

import '../../helpers/session_controller.dart';

class CompareDevTokenService {
  static Future<dynamic> getData(String devToken,String num) async {
    var response = await BaseClientClass.postwithheader(
        AppConfig().compareDeviceToken, {"DeviceToken":devToken,"mobile":num},
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      try {
        return compareDevTokenModelFromJson(response.body);
      } catch (e) {
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
