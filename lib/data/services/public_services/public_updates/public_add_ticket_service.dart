import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/encription.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart';

class PublicAddTicketService {
  static Future<dynamic> addTicketData(
      String reqNo, String message, String filePath) async {
    var url = AppConfig().publicAddTicketReply;
 
    var data = {
      "CaseId":encriptdatasingle(reqNo).toString() ,
      "Reply":encriptdatasingle(message).toString() ,
    };

    var response;
    response = await BaseClientClass.uploadFile(url ?? "", data, "File", filePath,
        token: SessionController().getPublicToken());

    if (response is StreamedResponse) {
      if (response.statusCode == 200) {
        return 'Ok';
      } else
        return response.statusCode;
    } else
      return response;
  }
}
