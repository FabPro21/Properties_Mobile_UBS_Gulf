import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_property_management/public_property_management_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicPropertyManagementService {
  static Future<dynamic> getPropertyManagement() async {
    var url = AppConfig().publicPropertyManagement;

    var resp = await BaseClientClass.post(url, {},
        token: SessionController().getPublicToken());
    if (resp is http.Response) {
      var data = publicGetPropertyManagementModelFromJson(resp.body);
      return data;
    }

    return resp;
  }
}
