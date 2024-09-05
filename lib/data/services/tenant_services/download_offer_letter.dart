import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class DownloadOfferLetter {
  static Future<dynamic> getData(int contractId) async {
    // add ContractId because it is 
    Map data = {"ContractId": contractId.toString()};
    var response =
        await BaseClientClass.post(AppConfig().downloadOfferLetter??"", data);
    if (response is http.Response) {
      try {
        var jsonResp = json.decode(response.body);
        String doc = jsonResp['path'];
        if (doc.isNotEmpty) {
          return base64Decode(doc.replaceAll('\n', ''));
        } else
          return AppMetaLabels().noDatafound;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
