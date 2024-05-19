import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class ContractDownloadService {
  static Future<dynamic> getData() async {
    var url = AppConfig().contractDownload;
    print(url);
    Map data = {"ContractId": SessionController().getContractID().toString()};
    print(data);
    var response = await BaseClientClass.post(url, data);
    print(response);
    if (response is http.Response) {
      print(response);
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
class ContractDownloadServiceNew {
  static Future<dynamic> getDataNew() async {
    var url = AppConfig().contractDownloadNew;
    print(url);
    Map data = {"ContractId": SessionController().getContractID().toString()};
    print(data);
    var response = await BaseClientClass.post(url, data);
    print(response);
    if (response is http.Response) {
      print(response);
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
