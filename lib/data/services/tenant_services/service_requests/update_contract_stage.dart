import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class UpdateContractStage {
  static Future<dynamic> updateStage(int dueActionId, int stageId) async {
    var data = {
      "DueActionid": dueActionId.toString(),
      "StageId": stageId.toString()
    };
    var response =
        await BaseClientClass.post(AppConfig().updateContractStage??"", data);
    if (response is http.Response) {
      try {
        var jsonResp = json.decode(response.body);
        print('Response::::: ${jsonResp['statusCode']}');
        if (jsonResp['statusCode'] == '200') {
          return 200;
        } else
          return jsonResp['message'];
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }

  // updateStageSignContract
  // calling this func because we want to retun whole reponse 
  static Future<dynamic> updateStageSignContract(int dueActionId, int stageId) async {
    var data = {
      "DueActionid": dueActionId.toString(),
      "StageId": stageId.toString()
    };
    var response =
        await BaseClientClass.post(AppConfig().updateContractStage??"", data);
    if (response is http.Response) {
      try {
        var jsonResp = json.decode(response.body);
        if (jsonResp['statusCode'] == '200') {
          return jsonResp;
        } else
          return jsonResp['message'];
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
  static Future<dynamic> updateStageSignContractNew(int dueActionId, int stageId) async {
    var data = {
      "DueActionid": dueActionId.toString(),
      "StageId": stageId.toString()
    };
    var response =
        await BaseClientClass.post(AppConfig().updateContractStage??"", data);
    if (response is http.Response) {
      try {
        var jsonResp = json.decode(response.body);
        if (jsonResp['statusCode'] == '200') {
          return jsonResp;
        } else
          return jsonResp['message'];
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
