import 'dart:convert';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/photo_file.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class VendorGetReqPhotos {
  static Future<dynamic> getPhotos(int caseNo, int roleId) async {
    final String url = AppConfig().vendorGetServiceRequestImages??"";
    Map data = {
      "CaseNo": caseNo.toString(),
      "RoleId": roleId.toString(),
    };
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        var resp = json.decode(response.body);
        if (resp['path'] != null || resp['path'].isNotEmpty()) {
          var bytePhotos = resp["path"] as List;
          var photoIds = resp["photoId"] as List;
          List<PhotoFile> reqPhotos = [];
          for (int i = 0; i < bytePhotos.length; i++) {
            reqPhotos.add(PhotoFile(
                file: base64Decode(bytePhotos[i].replaceAll('\n', '')),
                id: photoIds[i]));
          }
          return reqPhotos;
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
