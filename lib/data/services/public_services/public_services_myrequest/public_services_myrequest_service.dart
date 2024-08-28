import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_services_myrequest/public_services_myrequest_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';

class PublicGetServiceMyRequestService {
  static Future<dynamic> getServiceRequest() async {
    var url = AppConfig().getPublicServices;
    var data;
    var response = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      PublicServiceMyRequestModel getModel =
          publicServiceMyRequestModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
