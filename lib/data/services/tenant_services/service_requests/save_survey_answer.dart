import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class SaveSurveyAnswer {
  static Future<dynamic> saveAnswer(
      int customerChoice, int answerId, String desc, int isCompleted) async {
    var response = await BaseClientClass.post(AppConfig().saveSurveyAnswer??"", {
      "answerId": answerId,
      "customerChoice": customerChoice,
      "description": desc,
      "IsCompleted": isCompleted
    });
    if (response is http.Response) {
      try {
        var jsonResp = json.decode(response.body);
        if (jsonResp['status'] == 'Ok')
          return 'ok';
        else
          return jsonResp['message'];
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
