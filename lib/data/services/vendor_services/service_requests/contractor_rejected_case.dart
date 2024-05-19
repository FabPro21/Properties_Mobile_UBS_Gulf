import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class ContractorRejectedCase {
  static Future<dynamic> rejectCase(int caseId) async {
    Map data = {"CaseId": caseId.toString()};
    var resp = await BaseClientClass.post(AppConfig().contractorRejected, data);
    if (resp is http.Response) {
      return resp.statusCode;
    }
    return resp;
  }
}
