import 'dart:convert';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class VendorDownloadDoc {
  static Future<dynamic> downloadDoc(int caseNo, int roleId, int docId) async {
    final String url = AppConfig().vendorDownloadDoc;
    Map data = {
      "CaseNo": caseNo.toString(),
      "RoleId": roleId.toString(),
      "PhotoId": docId.toString()
    };
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        var resp = json.decode(response.body);
        var doc = resp['path'] as List;
        if (doc.isNotEmpty) {
          return base64Decode(doc.first.replaceAll('\n', ''));
        } else
          return AppMetaLabels().noDatafound;
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
