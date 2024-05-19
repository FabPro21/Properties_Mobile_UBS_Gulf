import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_services_myrequest/public_service_maininfo_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicServiceMainInfoService {
  static Future<dynamic> getServiceMainInfo(int caseno) async {
    var url = AppConfig().publicServiceMianinfo;
    var data = {"CaseNo":caseno.toString()};
    var response = await BaseClientClass.post(url , data,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      PublicServiceMainInfoModel getModel =
          publicServiceMainInfoModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
