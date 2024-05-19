import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../../data/models/public_models/public_booking_request/public_booking_request_agentlist_model.dart';
import '../../../helpers/session_controller.dart';

class PublicBookingRequestAgentServices {
  static Future<dynamic> getAgentList() async {
    var url = AppConfig().getPublicBookingAgentList;

    var data;

    var response = await BaseClientClass.post(url, data,
        token: SessionController().getPublicToken());

    if (response is http.Response) {
      PublicBookingRequestAgentModel getModel =
          publicBookingRequestAgentModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
