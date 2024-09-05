import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class UpdateContractDocumentStage {
  static Future<dynamic> updateStage(int dueActionId) async {
    var response = await BaseClientClass.post(
        AppConfig().updateContractDocumentStage??"", {"DueActionId":dueActionId.toString()});
    if (response is http.Response) {
      try {
        var jsonResp = json.decode(response.body);
        if (jsonResp['statusCode'] == '200')
          return 200;
        else
          return jsonResp['message'];
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
