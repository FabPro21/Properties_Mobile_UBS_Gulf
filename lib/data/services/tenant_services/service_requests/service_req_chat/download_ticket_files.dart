import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/constants/meta_labels.dart';

class DownloadTenantTicketFiles {
  static Future<dynamic> getData(int id) async {
    var url = AppConfig().downloadTicketFile;

    var response = await BaseClientClass.post(url ?? "", {"TicketReplyId":id.toString()});
    if (response is http.Response) {
      try {
        var jsonResp = json.decode(response.body);
        var doc = jsonResp['path'] as List;
        if (doc.isNotEmpty) {
          return base64Decode(doc[0].replaceAll('\n', ''));
        } else
          return AppMetaLabels().noDatafound;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
