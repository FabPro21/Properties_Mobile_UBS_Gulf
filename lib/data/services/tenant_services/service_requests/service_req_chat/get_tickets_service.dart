import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/get_ticket_replies_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class GetTicketsService {
  static Future<dynamic> getData(String reqNo) async {
    var url = AppConfig().getTicketReplies;

    var data={"CaseId":reqNo};

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      GetTicketRepliesModel ticketReplies =
          getTicketRepliesModelFromJson(response.body);
      return ticketReplies;
    }
    return response;
  }
}
