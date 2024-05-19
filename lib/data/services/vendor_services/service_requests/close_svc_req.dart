import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class CloseSvcReq {
  // 112233 Close Service Request
  static Future<dynamic> closeSvcReq(
      var caseId, String fabCorrectiveAction, remedy, description) async {
    // Map data = {"CaseNo": caseId.toString()};
    Map data1 = {
      "CaseNo": caseId.toString(),
      'FGPCorrectionId': fabCorrectiveAction,
      'ProposedRemedy': remedy,
      'Description': description
    };
    print('************************* === > $data1');
    // print('************************* === > $data');
    var resp = await BaseClientClass.post(AppConfig().vendorCloseRequest, data1);
    if (resp is http.Response) {
      return resp.statusCode;
    }
    return resp;
  }
}
