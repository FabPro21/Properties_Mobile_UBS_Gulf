import 'dart:convert';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/photo_file.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class GetReqThumbnails {
  static Future<dynamic> getThumbnails(int caseNo, int roleId) async {
    final String url =
        AppConfig().getServiceRequestThumbnailList??"";
        var data = {"CaseNo":caseNo.toString(),"RoleId":roleId.toString()};
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        var resp = json.decode(response.body);
        List<PhotoFile> photos = List<PhotoFile>.from(
            resp["data"].map((x) => PhotoFile.fromJson(x)));
        if (photos.isNotEmpty) {
          return photos;
        } else
          return 404;
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
