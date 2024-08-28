import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class VendorAcknowledgeCase {
  static Future<dynamic> acknowledgeCase(int caseId) async {
    Map data = {"CaseId": caseId.toString()};
    var resp =
        await BaseClientClass.post(AppConfig().vendorAcknowledgeCase??"", data);
    if (resp is http.Response) {
      return resp.statusCode;
    }
    return resp;
  }
}
