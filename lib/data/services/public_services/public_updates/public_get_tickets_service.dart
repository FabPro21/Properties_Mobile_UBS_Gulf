import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/session_controller.dart';
import '../../../models/tenant_models/service_request/get_ticket_replies_model.dart';

class PublicGetTicketsService {
  static Future<dynamic> getData(String reqNo) async {
    var url = AppConfig().publicGetTicketReplies;

  var data = {"CaseId": reqNo};
    // Map data;
    var response = await BaseClientClass.post(url, data,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      GetTicketRepliesModel ticketReplies =
          getTicketRepliesModelFromJson(response.body);
      return ticketReplies;
    }
    return response;
  }
}
