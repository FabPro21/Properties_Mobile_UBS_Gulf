import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/encription.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart';

class UploadVendorSign {
  static Future<dynamic> uploadFile(String reqNo, String filePath) async {
    var url = AppConfig().uploadVendorSign;

    var data = {
      'CaseNo': encriptdatasingle(reqNo).toString(),
    };
    var response;
    response = await BaseClientClass.uploadFile(url, data, 'File', filePath);
    if (response is StreamedResponse) {
      if (response.statusCode == 200) {
        return json.decode(await response.stream.bytesToString());
      } else
        return response.statusCode;
    } else
      return response;
  }
}

