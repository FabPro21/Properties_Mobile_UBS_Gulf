import 'dart:convert';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class VendorGetDocsByType {
  static Future<dynamic> getDocs(int caseNo, int roleId, int code) async {
    final String url = AppConfig().vendorGetDocsByType??"";
    Map data = {
      "CaseNo": caseNo.toString(),
      "RoleId": roleId.toString(),
      "Code": code.toString()
    };

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      print('response::::::::::: ==== > ${response.body}');
      try {
        var resp = json.decode(response.body);
        return List<DocFile>.from(
            resp["record"].map((x) => DocFile.fromJson(x)));
      } catch (e) {
        if (kDebugMode) print(e);
        print('Catch::::::::::: ==== > $response');
        return AppMetaLabels().anyError;
      }
    } else
      return response;
  }
}
